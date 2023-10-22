import 'package:blog_app/constant/constant.dart';
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
      width: double.infinity,
      color: Constant().plat,
      child: Text('explore'),
    );
  }
}
