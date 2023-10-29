// routes/blogroutes.js

const express = require('express');
const router = express.Router();
const blogController = require('../controllers/blogController');
const authMiddleware = require('../middleware/authMiddleware');



//for creating a blog post
router.post('/blogs', blogController.createBlog)



// Get all blogs
router.get('/', blogController.getAllBlogs);

// Get a single blog by ID
router.get('/:blogId', blogController.getBlogById);

// Update a blog by ID
router.put('/:blogId', authMiddleware, blogController.updateBlog);

// Delete a blog by ID
router.delete('/:blogId', authMiddleware, blogController.deleteBlog);

// Create a new comment on a blog
router.post('/:blogId/comments', authMiddleware, blogController.createComment);

// Create a like on a blog
router.post('/:blogId/like', authMiddleware, blogController.likeBlog);


module.exports = router;
