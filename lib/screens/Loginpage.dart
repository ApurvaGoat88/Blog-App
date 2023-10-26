import 'package:blog_app/Auth/auth.dart';
import 'package:blog_app/constant/constant.dart';
import 'package:blog_app/constant/google.dart';
import 'package:blog_app/screens/homepage.dart';
import 'package:blog_app/screens/sigup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _login() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email.text, password: _pass.text);
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User Not Found")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Wrong Password")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Unknown Error Occured")));
      }
    }

    Navigator.pop(context);
  }

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
      if (e.code == 'wrong-password') {
        print('user not found');
      }
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
                      key: _formKey,
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
                                          if (text == null ||
                                              text.isEmpty ||
                                              !text.contains('@')) {
                                            return 'Error Email';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: _email,
                                        textInputAction: TextInputAction.next,
                                        onSaved: (text) {},
                                        cursorColor: Constant().blue,
                                        decoration: InputDecoration(
                                          suffixIcon: const Icon(
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
                                            return 'Password error';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: _pass,
                                        obscureText: obs,
                                        textInputAction: TextInputAction.done,
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
                                      if (_formKey.currentState!.validate()) {
                                        await Auth().signIn(
                                            email: _email.text,
                                            pass: _pass.text);
                                        if (Auth().currentUser != null) {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Homepage()));
                                        }
                                      } else {
                                        print('error');
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
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 3), blurRadius: 10)
                                  ],
                                  color: Colors.white),
                              height: h * 0.1,
                              width: w * 0.6,
                              child: InkWell(
                                onTap: () async {
                                  User? user = await signInWithGoogle();
                                  if (user != null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Homepage()));
                                  } else {
                                    print('error');
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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

class LoginField extends StatefulWidget {
  const LoginField({super.key});

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final style = GoogleFonts.poppins();
  var tapcolor = Colors.white;
  final _color = Colors.black;
  void _login() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email.text, password: _pass.text);
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User Not Found")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Wrong Password")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Unknown Error Occured")));
      }
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.cyan.shade200,
      body: Container(
        color: Colors.white,
        height: h,
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: h * 0.2,
                  child: Image.asset(
                    "images/loginimage.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: h * 0.05,
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _email,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return "Enter a valid email ";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              filled: true,
                              suffixIcon: Icon(Icons.account_circle),
                              suffixIconColor: _color,
                              fillColor: Colors.transparent,
                              label: Text(
                                'Email',
                                style: style,
                              ),
                              labelStyle: TextStyle(color: _color),
                              hintText: '',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: _color),
                                borderRadius: BorderRadius.circular(23),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: _color),
                                borderRadius: BorderRadius.circular(23),
                              )),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        TextFormField(
                          controller: _pass,
                          validator: (val) {
                            if (val == null || val.trim().length < 7) {
                              return 'Password must be of 7 characters';
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: _color),
                              filled: true,
                              suffixIconColor: _color,
                              suffixIcon: Icon(Icons.lock_outline_rounded),
                              fillColor: Colors.transparent,
                              label: Text(
                                'Password',
                                style: style,
                              ),
                              hintText: '',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: _color),
                                borderRadius: BorderRadius.circular(23),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: _color),
                                borderRadius: BorderRadius.circular(23),
                              )),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        InkWell(
                          onTap: _login,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 19),
                            ),
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.circular(23)),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        GestureDetector(
                          onTap: () => googleAuth().signin(),
                          child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.cyan),
                                  borderRadius: BorderRadius.circular(20)),
                              height: h * 0.1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset('images/google.jpg'),
                                  Text(
                                    "Sign In Using Google",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        )

                        //mail
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
