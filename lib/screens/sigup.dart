import 'package:blog_app/Auth/auth.dart';
import 'package:blog_app/constant/constant.dart';
import 'package:blog_app/model/usermodel.dart';
import 'package:blog_app/provider/user-provider.dart';
import 'package:blog_app/screens/Loginpage.dart';
import 'package:blog_app/screens/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance;
  }

  final userProvider = UserProvider();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDatatoFireStore(UserModel user) async {
    print('addiing data');
    CollectionReference _db = _firestore.collection('Users');
    try {
      Map<String, dynamic> data = {
        'name': user.author,
        'email': user.email,
        'password': user.password,
      };
      await _db.add(data);
      print('added');
    } catch (e) {
      print('$e');
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;
      return user;
    } catch (e) {
      // Handle sign-in errors
      print(e.toString());
      return null;
    }
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> signUp({required String email, required String pass}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Email Already in Use')));
      }
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please check the provided password')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Something went Wrong')));
      }
      if (_pass.text != _cpass.text) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Password didnt Match')));
      }
    }
  }

  bool _obs = true;
  bool _obs2 = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _cpass = TextEditingController();
  TextEditingController _author = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Constant().blue,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Stack(
            children: [
              Container(
                height: h,
                width: w,
                child: SvgPicture.asset(
                  'assets/iPhone 14 & 15 Pro - 1.svg',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                // ignore: sort_child_properties_last
                child: Container(
                  decoration: BoxDecoration(
                      color: Constant().plat,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(h * 0.08),
                          bottomRight: Radius.circular(h * 0.08))),
                  height: h * 0.7,
                  // ignore: sort_child_properties_last
                  child: Form(
                      key: UniqueKey(),
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.all(w * 0.02),
                        margin: EdgeInsets.symmetric(horizontal: w * 0.04),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Sign Up',
                              style: GoogleFonts.ubuntu(
                                  fontSize: h * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Constant().vio),
                            ),
                            TextFormField(
                                cursorColor: Constant().blue,
                                validator: (text) {
                                  if (text == null ||
                                      text.isEmpty ||
                                      text.length <= 6) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Password must be more than 6 letters')));
                                    return 'Password must be more than 6 letters';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _author,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.person,
                                          color: Colors.black,
                                        )),
                                    hintText: 'Author Name',
                                    hintStyle: GoogleFonts.ubuntu(
                                        color: Constant().blue),
                                    labelStyle: GoogleFonts.ubuntu(
                                        color: Constant().blue),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Constant().blue)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Constant().blue)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Constant().blue))),
                                maxLines: 1),
                            Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(bottom: h * 0.01),
                                    child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Enter a AuthorName')));
                                            return 'Title Must not be Empty';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: _email,
                                        onSaved: (text) {},
                                        cursorColor: Constant().blue,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.email_outlined,
                                            color: Colors.black,
                                          ),
                                          hintText: 'Enter the Email',
                                          hintStyle: GoogleFonts.ubuntu(
                                              color: Constant().blue),
                                          labelStyle: GoogleFonts.ubuntu(
                                              color: Constant().blue),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Constant().blue)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Constant().blue)),
                                        ),
                                        maxLines: 1)),
                                Container(
                                    child: TextFormField(
                                        cursorColor: Constant().blue,
                                        validator: (text) {
                                          if (text == null ||
                                              text.isEmpty ||
                                              text.length <= 6) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Password must be more than 6 letters')));
                                            return 'Password must be more than 6 letters';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: _pass,
                                        obscureText: _obs,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  _obs = !_obs;
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  _obs
                                                      ? Icons
                                                          .remove_red_eye_outlined
                                                      : Icons.remove_red_eye,
                                                  color: Colors.black,
                                                )),
                                            hintText: 'Create a Password',
                                            hintStyle: GoogleFonts.ubuntu(
                                                color: Constant().blue),
                                            labelStyle: GoogleFonts.ubuntu(
                                                color: Constant().blue),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Constant().blue)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Constant().blue)),
                                            disabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Constant().blue))),
                                        maxLines: 1)),
                                Container(
                                    margin: EdgeInsets.only(top: h * 0.01),
                                    child: TextFormField(
                                        cursorColor: Constant().blue,
                                        validator: (text) {
                                          if (text == null ||
                                              text.isEmpty ||
                                              text.length <= 6) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Password must be more than 6 letters')));
                                            return 'Password must be more than 6 letters';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: _cpass,
                                        obscureText: _obs2,
                                        onSaved: (text) {},
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  _obs2 = !_obs2;
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  _obs2
                                                      ? Icons
                                                          .remove_red_eye_outlined
                                                      : Icons.remove_red_eye,
                                                  color: Colors.black,
                                                )),
                                            hintText: 'Re-Enter Password',
                                            hintStyle: GoogleFonts.ubuntu(
                                                color: Constant().blue),
                                            labelStyle: GoogleFonts.ubuntu(
                                                color: Constant().blue),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Constant().blue)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Constant().blue)),
                                            disabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Constant().blue))),
                                        maxLines: 1)),
                                Container(
                                  margin: EdgeInsets.only(top: h * 0.02),
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_pass.text == _cpass.text) {
                                        UserModel user = UserModel(
                                            author: _author.text,
                                            email: _email.text,
                                            password: _pass.text);
                                        FirebaseDatabase.instance
                                            .reference()
                                            .child("users")
                                            .push()
                                            .set({
                                          "name": user.author,
                                          "pass": user.password,
                                          "eamil": user.email
                                        });

                                        await signUp(
                                            email: _email.text,
                                            pass: _pass.text);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Password is not Same')));
                                      }
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: GoogleFonts.ubuntu(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        fixedSize: Size(w * 0.4, h * 0.05),
                                        backgroundColor: Constant().pink,
                                        foregroundColor: Constant().white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                  ),
                                )
                              ],
                            ),
                            Card(
                              elevation: 10,
                              child: Container(
                                height: h * 0.1,
                                width: w * 0.6,
                                child: InkWell(
                                  onTap: () async {
                                    User? user = await signInWithGoogle();

                                    if (user != null) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Homepage()));
                                    } else {
                                      print('error');
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/pngwing.com (7).png',
                                        fit: BoxFit.fitHeight,
                                      ),
                                      Text(
                                        'Google SignIn',
                                        style: GoogleFonts.ubuntu(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already a User ?'),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    },
                                    child: Text('Login'))
                              ],
                            )
                          ],
                        ),
                      )),
                  width: w,
                ),
                bottom: h * 0.08,
              )
            ],
          ),
        ),
      ),
    );
  }
}
