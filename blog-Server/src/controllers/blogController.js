// blogController.js
const Blog = require('../models/blog');
const mongoose = require('mongoose');


// Create a new blog
exports.createBlog = async (req, res) => {
  console.log("accepting the create request");
  try {
    const { title, content } = req.body;
    // const author = req.user.userId;
    const author = "random name";
    console.log('Received request to create a new blog:', { title, content });

    const blog = new Blog({ title, content });
    await blog.save();

    console.log('Blog created successfully:', blog);

    res.json({ message: 'Blog created successfully', blog });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server 3 Error' });
  }
};

// Get all blogs
exports.getAllBlogs = async (req, res) => {
  console.log("accepting the request to get all the blogs");
  try {
    const blogs = await Blog.find();
    res.json(blogs);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Get a single blog by ID

exports.getBlogById = async (req, res) => {
  console.log("Accept the request of getting a single blog");
  try {
    const blogId = req.params.blogId;

    // Validate that blogId is a valid ObjectId
    if (!mongoose.Types.ObjectId.isValid(blogId)) {
      return res.status(400).json({ error: 'Invalid blog ID' });
    }

    const blog = await Blog.findById(blogId);

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
  console.log("Accepting the Update a blog request");
  try {
    const { title, content } = req.body;
    const blog = await Blog.findById(req.params.blogId);

    console.log('Blog object:', blog);

    if (!blog) {
      return res.status(404).json({ error: 'Blog not found' });
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
  console.log("Accepting the delete blog request");
  try {
    const blog = await Blog.findById(req.params.blogId);

    if (!blog) {
      return res.status(404).json({ error: 'Blog not found' });
    }

    // Remove the blog from the database
    await blog.deleteOne();

    res.json({ message: 'Blog deleted successfully', blog });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

//create a comment 

/*exports.createComment = async (req, res) => {
  console.log("Accept the comment on a blog request");
  try {
    const  blogId  = req.params.blogId;
    const  text  = req.body;

    const blog = await Blog.findById(blogId);

    if (!blog) {
      return res.status(404).json({ error: 'Blog not found' });
    }

    const newComment = {
      text,
      
    };

    blog.comments.push(newComment);
    await blog.save();

    res.json({ message: 'Comment added successfully', comments: blog.comments });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};*/
// Create a comment on a blog
exports.createComment = async (req, res) => {
  console.log("Accept the comment on a blog request");
  try {
    const blogId = req.params.blogId;
    const { text } = req.body; 

    const blog = await Blog.findById(blogId);

    if (!blog) {
      return res.status(404).json({ error: 'Blog not found' });
    }

    const newComment = {
      text,
      // Add any other properties you want to include in the comment
      blogId // Assuming you want to associate the comment with a user
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
  console.log("accepting like a blog request");
  try {
    const blogId = req.params.blogId;
    console.log('Received request to like a blog. Blog ID:', blogId);

    const blog = await Blog.findById(blogId);
    console.log("find by ID");

    if (!blog) {
      return res.status(404).json({ error: 'Blog not found' });
    }

    // Ensure blog.likes is an array
    if (!Array.isArray(blog.likes)) {
      blog.likes = [];
    }

    // Check if the user has already liked the blog
    const isLiked = blog.likes.includes(req.blogId);

    if (isLiked) {
      return res.status(400).json({ error: 'Blog already liked by the user' });
    }

    // Add user's ID to the likes array
    blog.likes.push(req.blogId);
    await blog.save();

    // Send the correct data in the response
    res.json({ message: 'Blog liked successfully', likes: blog.likes });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};




