
const express = require('express');
const mongoose = require('mongoose');
const session = require('express-session');
const MongoStore = require('connect-mongo');
const cors = require('cors');
const nodemon = require('nodemon');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const authroutes = require('./routes/authroutes');
const blogroutes = require('./routes/blogroutes');
const User = require('./models/user');
const auth = require('../src/auth.js');
const db = require('../db');

const app = express();

app.use(cors());
app.use(express.json());

// Use express-session middleware
app.use(
  session({
    secret: 'bdcoe.akgec123', 
    resave: false,
    saveUninitialized: true,
    store: MongoStore.create({ mongoUrl: 'mongodb://127.0.0.1:27017/blogging-platform' }),
    cookie: { maxAge: 30 * 24 * 60 * 60 * 1000 }, // Session will expire after 30 days
  })
);

app.use(passport.initialize());
app.use(passport.session());

// Connect to MongoDB
mongoose.connect('mongodb://127.0.0.1:27017/blogging-platform', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Passport Local Strategy
passport.use(
  new LocalStrategy({ usernameField: 'email' }, async (email, password, done) => {
    try {
      const user = await User.findOne({ email });

      if (!user || !user.comparePassword(password)) {
        // User not found or invalid password
        return done(null, false, { message: 'Invalid credentials' });
      }

      // User and password are correct
      return done(null, user);
    } catch (error) {
      console.error(error);
      return done(error);
    }
  })
);



// Passport Serialization/Deserialization
passport.serializeUser((user, done) => {
  done(null, user.id);
});

passport.deserializeUser(async (id, done) => {
  try {
    // ... (rest of deserialization)
  } catch (error) {
    done(error);
  }
});

// Use auth routes
app.use('/api', authroutes);
app.use('/api', blogroutes);

//google authentication
app.get('/auth/google',
  passport.authenticate('google', { scope: ['email'] }));

app.get('/auth/google/callback', 
  passport.authenticate('google', { 
     successRedirect:'/auth/google/success',
     failurRedirect:'/auth/google/failure'
  }));

  //

app.get('/', (req, res) => {
  res.send('Hello, this is the root path!!');
});

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
