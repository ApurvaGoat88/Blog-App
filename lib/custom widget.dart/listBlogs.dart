import 'package:blog_app/constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBlogs extends StatefulWidget {
  const MyBlogs({super.key});

  @override
  State<MyBlogs> createState() => _MyBlogsState();
}

class _MyBlogsState extends State<MyBlogs> {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Blogs');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs
        .map(
          (e) => e.data(),
        )
        .toList();

    print(allData);
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    print(snapshot.data!.docs.length);
    final snap = snapshot.data!.docs
        .map((doc) => Center(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/digital-painted-portrait-of-lion-picjumbo-com.jpg'),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: EdgeInsets.all(w * 0.1),
                  child: Container(
                    margin: EdgeInsets.only(top: h * 0.4),
                    decoration: BoxDecoration(
                        color: Constant().plat,
                        borderRadius: BorderRadius.circular(34),
                        boxShadow: [
                          BoxShadow(blurRadius: 5, offset: Offset(0, 0.5))
                        ]),
                    width: w * 0.8,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            height: h * 0.12,
                            // color: Colors.redAccent,
                            child: Text(
                              doc['title'],
                              style: GoogleFonts.ubuntu(fontSize: h * 0.017),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ))
        .toList();
    return PageView.builder(
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
        stream: FirebaseFirestore.instance
            .collection("Blogs")
            .doc('apporvbraj')
            .collection('apporvbraj')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text("Please Add Blogs");
          return Card(child: getExpenseItems(snapshot));
        });
  }
}
