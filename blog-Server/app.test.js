// tests/api.test.js
const request = require('supertest');
const app = require('../index'); // Update the path based on your project structure

describe('Blog API Tests', () => {
  test('GET /blogs should return all blogs', async () => {
    const response = await request(app).get('/blogs');
    expect(response.statusCode).toBe(200);
    expect(response.body).toBeInstanceOf(Array); // Assuming it returns an array
  });

  test('GET /blogs/:blogTitle should return a specific blog', async () => {
    const blogTitle = 'example-blog';
    const response = await request(app).get(`/blogs/${blogTitle}`);
    expect(response.statusCode).toBe(200);
    // Add more assertions based on your actual response structure
  });

  test('POST /blogs should create a new blog', async () => {
    const newBlog = {
      title: 'New Blog',
      content: 'This is a new blog post.',
    };

    const response = await request(app)
      .post('/blogs')
      .send(newBlog);

    expect(response.statusCode).toBe(200);
    // Add more assertions based on your actual response structure
  });

  // Add more test cases for other API endpoints

  // ...

});
