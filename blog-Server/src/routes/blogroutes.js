const express = require('express');
const blogController = require('../controllers/blogController');
const router = express.Router();

router.get('/blogs', blogController.getAllBlogs);
router.post('/blogs', blogController.createBlog);
router.put('/blogs/:blogId', blogController.updateBlog);
router.delete('/blogs/:blogId', blogController.deleteBlog);

module.exports = router;