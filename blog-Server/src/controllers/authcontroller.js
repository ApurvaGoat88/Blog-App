const passport = require('passport');
const bcrypt = require('bcrypt');
const User = require('../models/user');
const jwt = require('jsonwebtoken');
const { secretKey, googleClientId } = require('../config'); // Assuming you have a secret key and Google client ID in your config
const { OAuth2Client } = require('google-auth-library');
const client = new OAuth2Client(googleClientId);

exports.signup = async (req, res) => {
  try {
    const { email, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);

    const user = new User({ email, password: hashedPassword });
    await user.save();

    // Generate a token for the newly created user
    const token = jwt.sign({ userId: user._id, email: user.email }, secretKey, { expiresIn: '1h' });

    res.json({ message: 'Signup successful', token });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

exports.login = async (req, res) => {
  passport.authenticate('local', (err, user) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: 'Internal Server Error' });
    }

    if (!user) {
      return res.status(401).json({ message: 'Login failed' });
    }

    // Generate a token for the authenticated user
    const token = jwt.sign({ userId: user._id, email: user.email }, secretKey, { expiresIn: '1h' });

    res.json({ message: 'Login successful', token });
  })(req, res);
};

exports.loginWithGoogle = async (req, res) => {
  try {
    const { tokenId } = req.body;
    const response = await client.verifyIdToken({ idToken: tokenId, audience: googleClientId });
    const { email_verified, email } = response.payload;

    if (email_verified) {
      let user = await User.findOne({ email });

      if (!user) {
        // If the user doesn't exist, create a new user
        user = new User({ email });
        await user.save();
      }

      // Generate a token for the authenticated user
      const token = jwt.sign({ userId: user._id, email: user.email }, secretKey, { expiresIn: '1h' });

      res.json({ message: 'Login successful with Google', token });
    } else {
      res.status(401).json({ message: 'Google authentication failed' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

exports.success = (req, res) => {
  res.json({ message: 'Login successful' });
};

exports.failure = (req, res) => {
  res.status(401).json({ message: 'Login failed' });
};

exports.createBlog = async (req, res) => {
  try {
    const { title, content } = req.body;

    // Check if the user is authenticated
    if (!req.isAuthenticated()) {
      return res.status(401).json({ message: 'Unauthorized' });
    }

    // Create a new blog associated with the logged-in user
    const blog = new Blog({ title, content, author: req.user._id });
    await blog.save();

    // Update the user's blogs array
    req.user.blogs.push(blog._id);
    await req.user.save();

    res.status(201).json(blog);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
};
