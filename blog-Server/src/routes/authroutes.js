// authRoutes.js
const express = require('express');
const authController = require('../controllers/authcontroller');
const passport = require('passport');
const router = express.Router();
const authMiddleware = require('../middleware/authMiddleware');
const blogController = require('../controllers/blogController');

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

// Create a new blog
router.post('/blogs', authMiddleware, blogController.createBlog);

//Update in a blog 
router.post('/blogs/:blogId/update',authMiddleware,blogController.updateBlog)

// Delete a blog
router.delete('/blogs/:blogId/delete', authMiddleware, blogController.deleteBlog);

// Create a comment on a blog
router.post('/blogs/:blogId/comments', authMiddleware, blogController.createComment);

// Create a like on a blog
router.post('/blogs/:blogId/like', authMiddleware, blogController.likeBlog);

module.exports = router;
