import 'package:flutter/material.dart';
import 'package:se_380_project/Screens/rate.dart';
import 'List_of_contents.dart';
import 'package:provider/provider.dart';
import './Providers/content_provider.dart';
import './Screens/content_detail_page.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ContentProvider(),
      child: MaterialApp(
        title: 'HaDiBe!',
        theme: ThemeData(
          primaryColor: Colors.black12,
        ),
        home: const ListOfContents(),
        routes: {
          ContentDetailPage.routeName: (context) => const ContentDetailPage(),
          Rate.routeName: (context) => const Rate(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
