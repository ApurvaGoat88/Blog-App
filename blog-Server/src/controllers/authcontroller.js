// authController.js
const passport = require('passport');
const bcrypt = require('bcrypt');
const User = require('../models/User');

exports.signup = async (req, res) => {
  try {
    const { email, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);

    const user = new User({ email, password: hashedPassword });
    await user.save();

    res.json({ message: 'Signup successful' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

exports.login = passport.authenticate('local', {
  successRedirect: '/api/success',
  failureRedirect: '/api/failure',
});

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