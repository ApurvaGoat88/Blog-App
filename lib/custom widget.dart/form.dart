import 'package:blog_app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormArea extends StatefulWidget {
  const FormArea({super.key});

  @override
  State<FormArea> createState() => _FormAreaState();
}

class _FormAreaState extends State<FormArea> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final w = MediaQuery.sizeOf(context).width;
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(w * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              padding: EdgeInsets.all(h * 0.02),
              child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Create a Blog',
                      labelStyle: GoogleFonts.ubuntu(color: Constant().pink),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Constant().blue)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Constant().blue)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Constant().blue))),
                  maxLines: null)),
        ],
      ),
    );
  }
}
