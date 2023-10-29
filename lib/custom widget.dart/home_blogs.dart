import 'package:blog_app/constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBlogs2 extends StatefulWidget {
  const MyBlogs2({super.key});

  @override
  State<MyBlogs2> createState() => _MyBlogs2State();
}

class _MyBlogs2State extends State<MyBlogs2> {
  final currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('AllBlogs');

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();

    final allData = querySnapshot.docs
        .map(
          (e) => e.data(),
        )
        .toList();
    print(allData);
  }

  getBlogs(AsyncSnapshot<QuerySnapshot> snapshot) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    print(snapshot.data!.docs.length);
    final snap = snapshot.data!.docs
        .map((doc) => Center(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/Android Large - 1 (2).png'),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: EdgeInsets.all(w * 0.05),
                  child: Container(
                    margin: EdgeInsets.only(top: h * 0.01),
                    decoration: BoxDecoration(
                        color: Constant().plat,
                        borderRadius: BorderRadius.circular(34),
                        boxShadow: [
                          BoxShadow(blurRadius: 5, offset: Offset(0, 0.5))
                        ]),
                    width: w * 0.8,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,

                            padding: EdgeInsets.all(10),

                            height: h * .7,
                            // color: Colors.redAccent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    doc['title'],
                                    style:
                                        GoogleFonts.ubuntu(fontSize: h * 0.04),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  doc['user'],
                                  style: GoogleFonts.ubuntu(
                                      fontSize: h * 0.01, color: Colors.red),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                Text(
                                  doc['content'],
                                  style: GoogleFonts.ubuntu(
                                      fontSize: h * 0.01, color: Colors.black),
                                  maxLines: 30,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ))
        .toList();
    return PageView.builder(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        return Card(
          color: Constant().plat,
          child: snap[index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("AllBlogs").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                color: Colors.pink,
              ),
            );
          return Card(child: getBlogs(snapshot));
        });
  }
}
