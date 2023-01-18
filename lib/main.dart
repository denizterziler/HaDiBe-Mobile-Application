import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/FirebaseContent/contentDetailFb.dart';
import 'package:se_380_project/FirebaseContent/firebaseRate.dart';
import 'package:se_380_project/Screens/comments.dart';
import 'package:se_380_project/Screens/login_page.dart';
import 'List_of_contents.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HaDiBe!',
      theme: ThemeData(
        primaryColor: Colors.black12,
      ),
      home: const LoginPage(),
      routes: {
        FirebaseRate.routeName:(context) => FirebaseRate(),
        ContentDetailFb.routeName:(context) => ContentDetailFb(),
        ListOfContents.routeName: (context) => ListOfContents(),
        Comments.routeName: (context) => const Comments(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}