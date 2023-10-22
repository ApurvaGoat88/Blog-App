import 'package:blog_app/constant/constant.dart';
import 'package:blog_app/provider/blog_provider.dart';
import 'package:blog_app/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BlogProvider>(context, listen: false);
    });
  }
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final w = MediaQuery.sizeOf(context).width;
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Stack(children: [
        Container(
            height: h,
            width: w,
            child: SvgPicture.asset(
              'assets/Android Large - 1.svg',
              fit: BoxFit.cover,
            )),
        Positioned(
            top: h * 0.6,
            left: w * 0.11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        text: 'Blog',
                        style: GoogleFonts.rubikDirt(
                            fontSize: h * 0.07, fontWeight: FontWeight.bold))),
                RichText(
                    text: TextSpan(
                  text: 'Know More about Others and \n',
                  children: [
                    TextSpan(
                      text: 'Happenings \n',
                      style: GoogleFonts.ubuntu(
                          color: Constant().pink,
                          fontSize: h * 0.021,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                  style: GoogleFonts.ubuntu(
                      fontSize: h * 0.021, fontWeight: FontWeight.w500),
                )),
                RichText(
                    text: TextSpan(
                  text:
                      "Save the moments that matter, Blog let's you safely \n store thousands of  posts,photos,and more for free.\n",
                  style: GoogleFonts.ubuntu(fontSize: h * 0.014),
                )),
                Container(
                  margin: EdgeInsets.only(left: w * 0.3),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Homepage()));
                    },
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 10,
                        fixedSize: Size(w * 0.4, h * 0.05),
                        backgroundColor: Constant().pink,
                        foregroundColor: Constant().white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                )
              ],
            ))
      ]),
    );
  }
}
