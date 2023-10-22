import 'package:blog_app/constant/constant.dart';
import 'package:blog_app/custom%20widget.dart/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogsCreate extends StatefulWidget {
  const BlogsCreate({super.key});

  @override
  State<BlogsCreate> createState() => _BlogsCreateState();
}

class _BlogsCreateState extends State<BlogsCreate> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 10,
        child: Container(
          height: h * 0.4,
          color: Constant().plat,
          child: Stack(children: [
            Opacity(
              opacity: 0.8,
              child: SvgPicture.asset(
                'assets/iPhone 14 & 15 Pro - 1bgcard.svg',
                fit: BoxFit.cover,
              ),
            ),
            Center(
                child: Container(
              child: Container(
                height: h * 0.6,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: h * 0.06),
                      child: Text(
                        'Create a New Blog ',
                        style: GoogleFonts.ubuntu(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: h * 0.03),
                      ),
                    ),
                    Form(
                      child: FormArea(),
                      key: GlobalKey(),
                    )
                  ],
                ),
              ),
            )),
          ]),
        ),
      ),
    );
  }
}
