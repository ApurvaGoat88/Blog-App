import 'package:blog_app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
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
                    )),
                height: h * 0.7,
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
                            'Login Page',
                            style: GoogleFonts.ubuntu(
                                fontSize: h * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Constant().vio),
                          ),
                          Container(
                              child: Column(
                            children: [
                              Container(
                                  margin:
                                      EdgeInsets.symmetric(vertical: h * 0.03),
                                  child: TextFormField(
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Title Must not be Empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (text) {},
                                      cursorColor: Constant().blue,
                                      decoration: InputDecoration(
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
                                      onSaved: (text) {},
                                      decoration: InputDecoration(
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
                              Container(
                                margin: EdgeInsets.only(top: h * 0.02),
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () {},
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
                                onTap: () {},
                                child: Image.asset(
                                  'assets/pngwing.com (7).png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                width: w,
              ),
              bottom: 0,
            )
          ],
        ),
      ),
    );
  }
}
