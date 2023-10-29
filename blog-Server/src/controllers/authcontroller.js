const passport = require('passport');
const bcrypt = require('bcrypt');
const User = require('../models/user');
const jwt = require('jsonwebtoken');
const { secretKey, googleClientId } = require('../config'); // Assuming you have a secret key and Google client ID in your config
const { OAuth2Client } = require('google-auth-library');
const client = new OAuth2Client(googleClientId);
const { validationResult } = require('express-validator');
const Blog = require('../models/blog');
const mongoose = require('mongoose');



exports.signup = async (req, res) => {
  console.log("accepted the sign up request");
  try {
    const { email, password } = req.body;
    console.log(req.body)
    const hashedPassword = await bcrypt.hash(password, 10);

    const user = new User({ email, password: hashedPassword });
    await user.save();

    // Generate a token for the newly created user
    const token = jwt.sign({ userId: user._id, email: user.email }, secretKey, { expiresIn: '1h' });

    res.json({ message: 'Signup successful', token });
  } catch (error) {
    console.error(error);
    res.status(500).json(error);
  }
};

exports.login = async (req, res) => {
  console.log("Login API Request Received");

  passport.authenticate('local', (err, user) => {
    console.log("Inside Passport Authenticate Callback");

    if (err) {
      console.error(err);
      console.log("Login error");
      return res.status(500).json(err);
    }


    if (!user) {
      console.log("Login failed: Invalid credentials");
      return res.status(401).json({ message: 'Login failed' });
    }

    console.log("Login successful. User:", user);

    // Generate a token for the authenticated user
    const token = jwt.sign({ userId: user._id, email: user.email }, secretKey, { expiresIn: '1h' });

    res.json({ message: 'Login successful', token });
  })(req, res);
};


exports.loginWithGoogle = async (req, res) => {
  console.log("login with google request accepted");
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

/*
exports.createBlog = async (req, res) => {
  console.log("request for creating a blog");
  try {
    // Validate request body
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ success: false, errors: errors.array() });
    }

    // Extract necessary data from the request
    const { title, content } = req.body;
   // const author = req.user.userId;

    // Create a new blog
    const blog = new Blog({ title, content, author });

    // Save the blog to the database
    await blog.save().catch((error) => {
      console.error(error);

      // Handle specific error scenarios
      if (error.code === 11000) {
        console.log("duplicate value entered");
        return res.status(400).json({ success: false, error: 'Duplicate entry. Blog with the same title already exists.' });
      }

      // Generic error response for other errors
      res.status(500).json({ success: false, error: 'Internal Server Error' });
      throw error;
    });

    // Update the user's blogs array
    req.user.blogs.push(blog._id);
    await req.user.save();

    // Respond with a success message and the created blog
    res.status(201).json({ success: true, message: 'Blog created successfully', data: blog });
  } catch (error) {
    console.error(error);

    // Generic error response for unexpected errors
    res.status(500).json({ success: false, error: 'Internal Server Error' });
  }
}; */





