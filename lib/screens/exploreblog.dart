import 'package:blog_app/constant/constant.dart';
import 'package:blog_app/model/ModelWidget.dart';
import 'package:flutter/material.dart';

class ExploreBlogs extends StatefulWidget {
  const ExploreBlogs({super.key});

  @override
  State<ExploreBlogs> createState() => _ExploreBlogsState();
}

class _ExploreBlogsState extends State<ExploreBlogs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constant().plat,
      child: ModelWidget(),
    );
  }
}
