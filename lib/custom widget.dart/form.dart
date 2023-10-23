import 'package:blog_app/constant/constant.dart';
import 'package:blog_app/provider/blog_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    final style =
        GoogleFonts.ubuntu(color: Constant().blue, fontSize: h * 0.02);
    return Consumer<BlogProvider>(builder: (context, value, child) {
      return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(w * 0.02),
        margin: EdgeInsets.symmetric(horizontal: w * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: h * 0.01),
                  child: Text(
                    'Title*',
                    style: style,
                  ),
                ),
              ],
            ),
            Container(
                child: TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Title Must not be Empty';
                      } else {
                        return null;
                      }
                    },
                    controller: value.title,
                    onSaved: (text) {
                      value.title.text = text.toString();
                    },
                    cursorColor: Constant().blue,
                    decoration: InputDecoration(
                      hintText: 'Give your Blog a Title',
                      hintStyle: GoogleFonts.ubuntu(color: Constant().blue),
                      labelStyle: GoogleFonts.ubuntu(color: Constant().blue),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Constant().blue)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Constant().blue)),
                    ),
                    maxLines: 1)),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: h * 0.01),
                  child: Text(
                    'Content*',
                    style: style,
                  ),
                ),
              ],
            ),
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
                    controller: value.content,
                    onSaved: (text) {
                      value.content.text = text.toString();
                    },
                    decoration: InputDecoration(
                        hintText: 'Content of Blog',
                        hintStyle: GoogleFonts.ubuntu(color: Constant().blue),
                        labelStyle: GoogleFonts.ubuntu(color: Constant().blue),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constant().blue)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constant().blue)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constant().blue))),
                    maxLines: 5)),
            Container(
              margin: EdgeInsets.only(top: h * 0.02),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  if (value.title.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Title Field cant be empty',
                          style: style,
                        ),
                        dismissDirection: DismissDirection.horizontal,
                        backgroundColor: Colors.pink.shade100));
                  }
                  if (value.content.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Content Field cant be Empty',
                          style: style,
                        ),
                        duration: Duration(seconds: 2),
                        dismissDirection: DismissDirection.horizontal,
                        backgroundColor: Colors.pink.shade100));
                  } else {
                    print(value.content.text.toString());
                  }
                },
                child: Text(
                  'Create Blog',
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
        ),
      );
    });
  }
}
