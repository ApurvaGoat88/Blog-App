import 'package:blog_app/Auth/auth.dart';
import 'package:blog_app/firebase_options.dart';
import 'package:blog_app/provider/blog_provider.dart';
import 'package:blog_app/provider/user-provider.dart';
import 'package:blog_app/screens/homepage.dart';
import 'package:blog_app/screens/startpage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BlogProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: StreamBuilder(
            stream: Auth().authState,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const Homepage();
              } else {
                return const StartPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
