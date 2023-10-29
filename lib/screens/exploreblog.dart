import 'package:blog_app/constant/constant.dart';
import 'package:blog_app/model/ModelWidget.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ExploreBlogs extends StatefulWidget {
  const ExploreBlogs({super.key});

  @override
  State<ExploreBlogs> createState() => _ExploreBlogsState();
}

class _ExploreBlogsState extends State<ExploreBlogs> {
  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      springAnimationDurationInMilliseconds: 500,
      backgroundColor: Constant().plat,
      color: Constant().pink,
      onRefresh: () async {},
      child: Container(
        color: Constant().plat,
        child: ModelWidget(),
      ),
    );
  }
}
