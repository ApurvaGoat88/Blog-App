// models/Blog.js
const mongoose = require('mongoose');

const blogSchema = new mongoose.Schema({
  title: { type: String, required: true },
  content: { type: String, required: true },
  // author: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  likes: [{ type: Number, default: [0] }],
  comments: [{ type: String }],
});

const Blog = mongoose.model('Blog', blogSchema);

module.exports = Blog;
