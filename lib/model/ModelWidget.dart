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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Card(
                color: Colors.grey.shade200,
                child: Container(
                  height: h * 0.1,
                  child: Row(
                    children: [
                      Container(
                        width: w * 0.3,
                        child: Card(
                          child: Image.asset(
                            'assets/cute-dog-in-halloween-costume-picjumbo-com.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.08,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            color: Colors.transparent,
                            width: w * 0.63,
                            alignment: Alignment.center,
                            child: Text(
                              'It seems like youd like more information about Flutter.Flutter is an open-source UI software development toolkit created\n by Google for building natively compiled \napplications for mobile, web, and desktop\n from a single codebase.',
                              style: GoogleFonts.poppins(fontSize: 8),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: h * 0.7,
            child: PageView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleBlogPage()));
                    },
                    // ignore: avoid_unnecessary_containers
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Expanded(
                            child: Image.asset(
                              'assets/abstract-psychedelic-visualization-of-brain-connections-in-mind-picjumbo-com.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              bottom: h * 0.05,
                              left: w * 0.1,
                              child: Opacity(
                                opacity: 0.9,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  height: h * 0.15,
                                  width: w * 0.7,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Dont be afraid togive up \nthe good togo for the great.',
                                            style: GoogleFonts.ubuntu(
                                                fontSize: h * 0.02),
                                          ),
                                          SizedBox(height: h * 0.02),
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: w * 0.02),
                                                child: Text(
                                                  'Freelance',
                                                  style: GoogleFonts.ubuntu(
                                                      color: Colors.red,
                                                      fontSize: 15),
                                                ),
                                              )
                                            ],
                                          )
                                        ]),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
            ),
          ),
          Container(
            height: h,
            child: Expanded(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Card(
                        color: Colors.grey.shade200,
                        child: Container(
                          height: h * 0.1,
                          child: Row(
                            children: [
                              Container(
                                width: w * 0.3,
                                child: Card(
                                  child: Image.asset(
                                    'assets/cute-dog-in-halloween-costume-picjumbo-com.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.08,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    color: Colors.transparent,
                                    width: w * 0.63,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'It seems like youd like more information about Flutter.Flutter is an open-source UI software development toolkit created\n by Google for building natively compiled \napplications for mobile, web, and desktop\n from a single codebase.',
                                      style: GoogleFonts.poppins(fontSize: 8),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
