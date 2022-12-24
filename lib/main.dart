import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/Screens/comments.dart';
import 'package:se_380_project/Screens/favorites.dart';
import 'package:se_380_project/Screens/login_page.dart';
import 'package:se_380_project/Screens/rate.dart';
import 'package:se_380_project/Screens/search.dart';
import 'List_of_contents.dart';
import 'package:provider/provider.dart';
import './Providers/content_provider.dart';
import './Screens/content_detail_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyAp());
}

class MyAp extends StatelessWidget {
  const MyAp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: LoginPage(),
    );
  }
}

class MyAppp extends StatelessWidget {
  const MyAppp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<ContentProvider>.value(
        value: ContentProvider(),
      )
      ],
      child: MaterialApp(
        title: 'HaDiBe!',
        theme: ThemeData(
          primaryColor: Colors.black12,
        ),
        home: const ListOfContents(),
        routes: {
          ContentDetailPage.routeName: (context) => const ContentDetailPage(),
          Rate.routeName: (context) => const Rate(),
          Favorites.routeName: (context) => const Favorites(),
          SearchPage.routeName: (context) => const SearchPage(),
          Comments.routeName: (context) => const Comments(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}