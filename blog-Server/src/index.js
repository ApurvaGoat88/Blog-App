const express = require('express');
const mongoose = require('mongoose');
const session = require('express-session');
const MongoStore = require('connect-mongo');
const cors = require('cors');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const authroutes = require('./routes/authroutes');
const blogroutes = require('./routes/blogroutes');

const app = express();

app.use(cors());
app.use(express.json());

// Use express-session middleware
app.use(
  session({
    secret: 'bdcoe.akgec123', // Replace with a strong and secure secret key
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
      // ... (rest of the strategy)
    } catch (error) {
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

app.get('/', (req, res) => {
  res.send('Hello, this is the root path!!');
});

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
