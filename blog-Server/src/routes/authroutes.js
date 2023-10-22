// authRoutes.js
const express = require('express');
const authcontroller = require('../controllers/authcontroller');
const passport = require('passport');
const router = express.Router();

router.post('/signup', authcontroller.signup);
router.post('/login', authcontroller.login);

router.get('/success', authcontroller.success);
router.get('/failure', authcontroller.failure);

module.exports = router;
