import 'package:blog_app/constant/constant.dart';
import 'package:blog_app/screens/homepage.dart';
import 'package:blog_app/screens/sigup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('We Have sent you a mail for password reset')));
    } catch (e) {
      // Handle errors here
      print('Error: $e');
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
  User? get currentUser => _firebaseAuth.currentUser;
  Future<void> signIn({required String email, required String pass}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pass);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } on FirebaseAuthException catch (e) {
      print(e.toString());

      // ignore: unnecessary_null_comparison
    }
  }

  bool obs = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
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
                  'assets/Android Large - 1.svg',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                // ignore: sort_child_properties_last
                child: Container(
                  decoration: BoxDecoration(
                      color: Constant().plat,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(h * 0.08),
                          bottomLeft: Radius.circular(h * 0.08))),
                  height: h * 0.7,
                  width: w,
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
                              'Login ',
                              style: GoogleFonts.ubuntu(
                                  fontSize: h * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Constant().vio),
                            ),
                            Container(
                                child: Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: h * 0.03),
                                    child: TextFormField(
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
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
                                          if (text == null || text.isEmpty) {
                                            return 'Content Must not be Empty';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: _pass,
                                        obscureText: obs,
                                        onSaved: (text) {},
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    obs = !obs;
                                                  });
                                                },
                                                icon: Icon(obs
                                                    ? Icons
                                                        .remove_red_eye_outlined
                                                    : Icons.remove_red_eye)),
                                            hintText: 'Enter Password',
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
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () async {
                                          if (_email.text.length != 0 &&
                                              _email.text.contains('@')) {
                                            await resetPassword(_email.text);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Enter a Valid email')));
                                          }
                                        },
                                        child: Text('Forgot Password')),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: h * 0.02),
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_email.text != _pass.text) {
                                        await signIn(
                                            email: _email.text,
                                            pass: _pass.text);
                                      }
                                    },
                                    child: Text(
                                      'Login',
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
                            )),
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
                                Text('New User?'),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignUP()));
                                    },
                                    child: Text('Create Account'))
                              ],
                            )
                          ],
                        ),
                      )),
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
