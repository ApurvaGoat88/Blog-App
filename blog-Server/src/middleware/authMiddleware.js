// authMiddleware.js

const jwt = require('jsonwebtoken');
const { secretKey } = require('../config'); // You need to define your secret key

const authMiddleware = (req, res, next) => {
  // Check for the presence of the 'Authorization' header
  try {
  const firstToken = req.header('Authorization');
  const token = firstToken.split(' ')[1];
  console.log(token);

  if (!token) {
    console.log('Unauthorized - No token provided');
    return res.status(401).json({ error: 'Unauthorized - No token provided' });
  }

    // Verify the token
    const decoded = jwt.verify(token, secretKey);
    console.log(decoded.user);

    // Attach the decoded user information to the request object
    req.body._id = decoded?.id;

    console.log('Token verified successfully:', decoded.user);

    next(); // Continue to the next middleware or route handler
  } catch (error) {
    console.error(error);
    return res.status(401).json(error.message);
  }
};

module.exports = authMiddleware;