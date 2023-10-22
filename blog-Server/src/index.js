const express = require('express');
const mongoose = require('mongoose');
const session = require('express-session');
const MongoStore = require('connect-mongo')(session);
const cors = require('cors');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const authroutes = require('./routes/authroutes');
const blogroutes = require('./routes/blogroutes');

const app = express();

app.use(cors());
app.use(express.json());

// Connect to MongoDB
mongoose.connect('mongodb://127.0.0.1:27017/blogging-platform', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Create a new MongoStore instance
const sessionStore = new MongoStore({ mongooseConnection: mongoose.connection });

// Use express-session
app.use(
  session({
    secret: 'your-secret-key', // Replace with a strong and secure secret key
    resave: false,
    saveUninitialized: true,
    store: sessionStore,
    cookie: { maxAge: 30 * 24 * 60 * 60 * 1000 }, // Session will expire after 30 days
  })
);

app.use(passport.initialize());
app.use(passport.session());

// Passport Local Strategy
passport.use(
  new LocalStrategy({ usernameField: 'email' }, async (email, password, done) => {
    try {
      const user = await User.findOne({ email });

      if (!user) {
        return done(null, false, { message: 'Incorrect email.' });
      }

      const passwordMatch = await bcrypt.compare(password, user.password);

      if (!passwordMatch) {
        return done(null, false, { message: 'Incorrect password.' });
      }

      return done(null, user);
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
    const user = await User.findById(id);
    done(null, user);
  } catch (error) {
    done(error);
  }
});

// Use auth routes
app.use('/api', authroutes);
app.use('/api', blogroutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
