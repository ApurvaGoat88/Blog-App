import 'package:blog_app/constant/constant.dart';
import 'package:blog_app/custom%20widget.dart/listBlogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return Scaffold(
        backgroundColor: Constant().plat,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(currentUser!.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userdata = snapshot.data!.data() as Map<String, dynamic>;
              final dataCollection = FirebaseFirestore.instance
                  .collection('Blogs')
                  .doc(userdata['UserId'])
                  .collection(userdata['UserId']);

              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  height: h * 1.3,
                  width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: h * 0.05),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'assets/—Pngtree—businessman user avatar wearing suit_8385663.png',
                            height: 80,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Row(
                        children: [
                          Container(
                              color: Constant().plat,
                              margin: EdgeInsets.only(left: w * 0.05),
                              child: Text('User Details')),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            child: Container(
                                color: Constant().plat,
                                height: h * 0.08,
                                alignment: Alignment.centerLeft,
                                width: w * 0.9,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Username',
                                          style: GoogleFonts.ubuntu(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      color: Constant().plat,
                                      padding: EdgeInsets.all(h * 0.01),
                                      child: Text(
                                        userdata['name'].toString(),
                                        style: GoogleFonts.ubuntu(
                                            fontSize: h * 0.02),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Card(
                            child: Container(
                                color: Constant().plat,
                                height: h * 0.08,
                                alignment: Alignment.centerLeft,
                                width: w * 0.9,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Email',
                                          style: GoogleFonts.ubuntu(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      color: Constant().plat,
                                      padding: EdgeInsets.all(h * 0.01),
                                      child: Text(
                                        userdata['email'].toString(),
                                        style: GoogleFonts.ubuntu(
                                            fontSize: h * 0.02),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Card(
                            child: Container(
                                color: Constant().plat,
                                height: h * 0.7,
                                alignment: Alignment.centerLeft,
                                width: w * 0.9,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'BLogss',
                                          style: GoogleFonts.ubuntu(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(h * 0.01),
                                          child: MyBlogs()),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
