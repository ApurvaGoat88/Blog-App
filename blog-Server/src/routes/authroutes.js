// authRoutes.js
const express = require('express');
const authController = require('../controllers/authcontroller');
const passport = require('passport');
const router = express.Router();
const authMiddleware = require('../middleware/authMiddleware');
const blogController = require('../controllers/blogController');

router.post('/signup', authController.signup);
router.post('/login', authController.login);

router.get('/success', authController.success);
router.get('/failure', authController.failure);

// Create a comment on a blog
router.post('/blogs/:blogId/comments', authMiddleware, blogController.createComment);

// Create a like on a blog
router.post('/blogs/:blogId/like', authMiddleware, blogController.likeBlog);

module.exports = router;
