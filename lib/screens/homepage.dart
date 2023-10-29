import 'package:blog_app/Auth/auth.dart';
import 'package:blog_app/constant/constant.dart';
import 'package:blog_app/screens/crud_blog.dart';
import 'package:blog_app/screens/exploreblog.dart';
import 'package:blog_app/screens/profile.dart';
import 'package:blog_app/screens/startpage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int current_index = 0;
  List<Widget> list = <Widget>[ExploreBlogs(), BlogsCreate(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Constant().plat,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Constant().plat,
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
                text: 'B',
                children: [
                  TextSpan(
                    text: 'log App',
                    style: GoogleFonts.ubuntu(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )
                ],
                style: GoogleFonts.ubuntu(
                    color: Constant().pink,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        actions: [
          current_index == 2
              ? Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Card(
                    color: Constant().plat,
                    shape: CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(
                          onPressed: () async {
                            await Auth().signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => StartPage())));
                          },
                          icon: Icon(
                            Icons.logout_rounded,
                            color: Colors.black,
                          )),
                    ),
                  ),
                )
              : Center()
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: h * 0.8,
          color: Constant().plat,
          child: list[current_index],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          height: h * 0.08,
          buttonBackgroundColor: Colors.pink.shade200,
          animationDuration: Duration(milliseconds: 500),
          onTap: (index) {
            print(index);
            setState(() {
              current_index = index;
              print(current_index);
            });
            setState(() {});
          },
          items: [
            Icon(Icons.home_filled, size: 30, color: Constant().blue),
            Icon(Icons.add, size: 30, color: Constant().blue),
            Icon(Icons.person, size: 30, color: Constant().blue),
          ]),
    );
  }
}
