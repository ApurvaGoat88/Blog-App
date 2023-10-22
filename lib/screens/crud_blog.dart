import 'package:blog_app/constant/constant.dart';
import 'package:blog_app/custom%20widget.dart/form.dart';
import 'package:flutter/material.dart';
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

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        height: h,
        color: Constant().plat,
        child: Center(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: h * 0.06),
              child: Text(
                'Add a New Blog ',
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
        )),
      ),
    );
  }
}
