import 'package:blog_app/custom%20widget.dart/home_blogs.dart';
import 'package:blog_app/custom%20widget.dart/listBlogs.dart';
import 'package:blog_app/screens/SingleBlog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModelWidget extends StatefulWidget {
  const ModelWidget({super.key});

  @override
  State<ModelWidget> createState() => _ModelWidgetState();
}

class _ModelWidgetState extends State<ModelWidget> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final w = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: SizedBox(height: h * 0.8, child: MyBlogs2()),
    );
  }
}
