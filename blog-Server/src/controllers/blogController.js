// blogController.js
const Blog = require('../models/blog');

// Create a new blog
exports.createBlog = async (req, res) => {
  try {
    const { title, content } = req.body;
    const author = req.user.userId;

    console.log('Received request to create a new blog:', { title, content, author });

    const blog = new Blog({ title, content, author });
    await blog.save();

    console.log('Blog created successfully:', blog);

    res.json({ message: 'Blog created successfully', blog });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Get all blogs
exports.getAllBlogs = async (req, res) => {
  try {
    const blogs = await Blog.find().populate('author', 'email');
    res.json(blogs);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Get a single blog by ID
exports.getBlogById = async (req, res) => {
  try {
    const blog = await Blog.findById(req.params.blogId).populate('author', 'email');

    if (!blog) {
      return res.status(404).json({ error: 'Blog not found' });
    }

    res.json(blog);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Update a blog by ID
exports.updateBlog = async (req, res) => {
  try {
    const { title, content } = req.body;
    const blog = await Blog.findById(req.params.blogId);

    if (!blog) {
      return res.status(404).json({ error: 'Blog not found' });
    }

    // Ensure the user is the author of the blog
    if (blog.author.toString() !== req.user.userId) {
      return res.status(403).json({ error: 'Unauthorized' });
    }

    blog.title = title;
    blog.content = content;
    await blog.save();

    res.json({ message: 'Blog updated successfully', blog });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Delete a blog by ID
exports.deleteBlog = async (req, res) => {
  try {
    const blog = await Blog.findById(req.params.blogId);

    if (!blog) {
      return res.status(404).json({ error: 'Blog not found' });
    }

    // Ensure the user is the author of the blog
    if (blog.author.toString() !== req.user.userId) {
      return res.status(403).json({ error: 'Unauthorized' });
    }

    await blog.remove();

    res.json({ message: 'Blog deleted successfully', blog });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }

  

};

exports.createComment = async (req, res) => {
  try {
    const { blogId } = req.params;
    const { text } = req.body;

    const blog = await Blog.findById(blogId);

    if (!blog) {
      return res.status(404).json({ error: 'Blog not found' });
    }

    const newComment = {
      text,
      user: req.user.userId,
    };

    blog.comments.push(newComment);
    await blog.save();

    res.json({ message: 'Comment added successfully', comments: blog.comments });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Create a like on a blog
exports.likeBlog = async (req, res) => {
  try {
    const { blogId } = req.params;

    const blog = await Blog.findById(blogId);

    if (!blog) {
      return res.status(404).json({ error: 'Blog not found' });
    }

    // Check if the user has already liked the blog
    const isLiked = blog.likes.includes(req.user.userId);

    if (isLiked) {
      return res.status(400).json({ error: 'Blog already liked by the user' });
    }

    blog.likes.push(req.user.userId);
    await blog.save();

    res.json({ message: 'Blog liked successfully', likes: blog.likes });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};
