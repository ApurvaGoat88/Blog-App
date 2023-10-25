// authMiddleware.js

const jwt = require('jsonwebtoken');
const { secretKey } = require('../config'); // You need to define your secret key

const authMiddleware = (req, res, next) => {
  // Check for the presence of the 'Authorization' header
  const token = req.header('Authorization');

  if (!token) {
    console.log('Unauthorized - No token provided');
    return res.status(401).json({ error: 'Unauthorized - No token provided' });
  }

  try {
    // Verify the token
    const decoded = jwt.verify(token, secretKey);

    // Attach the decoded user information to the request object
    req.user = decoded.user;

    console.log('Token verified successfully:', decoded.user);

    next(); // Continue to the next middleware or route handler
  } catch (error) {
    console.error(error);
    return res.status(401).json({ error: 'Unauthorized - Invalid token' });
  }
};

module.exports = authMiddleware;
