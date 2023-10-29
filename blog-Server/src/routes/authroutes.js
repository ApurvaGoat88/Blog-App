// authRoutes.js
const express = require('express');
const authController = require('../controllers/authcontroller');
const passport = require('passport');
const router = express.Router();
const authMiddleware = require('../middleware/authMiddleware');
const blogController = require('../controllers/blogController');
const auth = require('../auth.js');

//signup route
router.post('/signup', authController.signup);

// Login route
router.post('/login', authController.login);

// Login with Google route (example)
router.get('/google', passport.authenticate('google', { scope: ['profile', 'email'] }));

// Callback route for Google login
router.get('/google/callback', passport.authenticate('google', { failureRedirect: '/failure' }), (req, res) => {
  res.redirect('/success');
});


router.get('/success', authController.success);
router.get('/failure', authController.failure);

module.exports = router;
