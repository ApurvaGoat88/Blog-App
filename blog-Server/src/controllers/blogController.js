// blogController.js
const Blog = require('../models/blog');

exports.getAllBlogs = async (req, res) => {
  try {
    const blogs = await Blog.find();
    res.json(blogs);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

exports.createBlog = async (req, res) => {
  try {
    const { title, content } = req.body;
    const blog = new Blog({ title, content });
    await blog.save();
    res.status(201).json(blog);
} catch (error) {
  console.error(error);
  res.status(500).json({ message: 'Internal Server Error' });
}
};

exports.updateBlog = async (req, res) => {
try {
  const { title, content } = req.body;
  const blogId = req.params.blogId;

  const updatedBlog = await Blog.findByIdAndUpdate(
    blogId,
    { title, content },
    { new: true }
  );

  if (!updatedBlog) {
    return res.status(404).json({ message: 'Blog not found' });
  }

  res.json(updatedBlog);
} catch (error) {
  console.error(error);
  res.status(500).json({ message: 'Internal Server Error' });
}
};

exports.deleteBlog = async (req, res) => {
try {
  const blogId = req.params.blogId;

  const deletedBlog = await Blog.findByIdAndDelete(blogId);

  if (!deletedBlog) {
    return res.status(404).json({ message: 'Blog not found' });
  }

  res.json({ message: 'Blog deleted successfully' });
} catch (error) {
  console.error(error);
  res.status(500).json({ message: 'Internal Server Error' });
}
};
