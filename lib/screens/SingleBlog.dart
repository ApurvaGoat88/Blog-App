import 'package:blog_app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleBlogPage extends StatefulWidget {
  const SingleBlogPage({super.key});

  @override
  State<SingleBlogPage> createState() => _SingleBlogPageState();
}

class _SingleBlogPageState extends State<SingleBlogPage> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final w = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constant().white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Hero(
              transitionOnUserGestures: true,
              tag: 'tag',
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Freelancer',
                          style: GoogleFonts.ubuntu(
                              fontSize: 16, color: Colors.red),
                        )
                      ],
                    ),
                    Text(
                      'Dont be afraid to give up \nthe good to go for the great.',
                      style: GoogleFonts.ubuntu(fontSize: h * 0.03),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Image.asset(
                            'assets/abstract-psychedelic-visualization-of-brain-connections-in-mind-picjumbo-com.jpg'),
                      ),
                    ),
                    Text(
                      'I failed the first quarter of a class in school, \nso Imade a fake report card. \nI did this every quarterthat year. I forgot that they mail home the end-year cards, \nand my mom got it before I couldintercept information.Every quarter that year. I forgot that they mailhome the end-year cards.',
                      style: GoogleFonts.ubuntu(fontSize: 17),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
