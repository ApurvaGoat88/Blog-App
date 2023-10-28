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
  final user = FirebaseAuth.instance.currentUser;

  final currentUser = FirebaseAuth.instance.currentUser;
  Future<void> updateData(
      String cuurent_title, String title, String content, key) async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;
      Map<String, dynamic> data = {
        'title': title,
        'content': content,
        'user': key
      };
      await firestoreInstance
          .collection('Blogs')
          .doc(user!.email!.split('@')[0].toString())
          .collection(user!.email!.split('@')[0].toString())
          .doc(cuurent_title)
          .update(data);
      await firestoreInstance
          .collection('AllBlogs')
          .doc(cuurent_title)
          .update(data);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Blog Upadted')));
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }

  Future<void> deleteData(String title) async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;

      await firestoreInstance
          .collection('Blogs')
          .doc(user!.email!.split('@')[0].toString())
          .collection(user!.email!.split('@')[0].toString())
          .doc(title)
          .delete();
      await firestoreInstance.collection('AllBlogs').doc(title).delete();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Blog Deleted')));
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }

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

  final _title = TextEditingController();
  final _content = TextEditingController();
  Future<void> _showEditBox(BuildContext context, String cuurent_title) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Your Blog'),
          content: Form(
            key: GlobalKey(),
            child: Container(
              height: h * 0.5,
              width: w * 0.8,
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _title,
                      decoration: InputDecoration(
                          hintText: 'Title*',
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    TextFormField(
                      controller: _content,
                      decoration: InputDecoration(
                          hintText: 'Content*',
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder()),
                      maxLines: 7,
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel')),
                        TextButton(
                            onPressed: () async {
                              if (_title.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Please,Provide Title')));
                              } else if (_content.text.isEmpty) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Please,Provide Content')));
                              } else {
                                await updateData(
                                    cuurent_title,
                                    _title.text,
                                    _content.text,
                                    currentUser!.email!.split('@')[0]);
                                Navigator.pop(context);
                              }
                            },
                            child: Text('Update')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
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
                        image: AssetImage(
                            'assets/digital-painted-portrait-of-lion-picjumbo-com.jpg'),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    print('delete');
                                    await deleteData(doc['title']);
                                  },
                                  icon: Icon(Icons.delete)),
                              IconButton(
                                  onPressed: () {
                                    _showEditBox(context, doc['title']);
                                  },
                                  icon: Icon(Icons.edit))
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            height: h * 0.5,
                            // color: Colors.redAccent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  doc['title'],
                                  style: GoogleFonts.ubuntu(fontSize: h * 0.04),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  doc['user'],
                                  style: GoogleFonts.ubuntu(
                                      fontSize: h * 0.01, color: Colors.red),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                Text(
                                  doc['content'],
                                  style: GoogleFonts.ubuntu(
                                      fontSize: h * 0.01, color: Colors.black),
                                  maxLines: 20,
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
      physics: BouncingScrollPhysics(),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        return snapshot.data!.docs.length == 0
            ? Card(child: Center(child: Text('PLEASE ADD BLOGS')))
            : Card(
                color: Constant().plat,
                child: snap[index],
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Blogs")
            .doc(currentUser!.email!.split('@')[0].toString())
            .collection(currentUser!.email!.split('@')[0].toString())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text("Please Add Blogs");
          return Card(child: getBlogs(snapshot));
        });
  }
}
