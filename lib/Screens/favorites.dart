import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_380_project/Providers/content_provider.dart';
import 'package:se_380_project/Widgets/content_grid.dart';
class Favorites extends StatefulWidget {
  static const routeName = '/favorites';

  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    var contentName = ModalRoute.of(context)?.settings.arguments as String;
    var loadedContent = Provider.of<ContentProvider>(context)
        .items
        .firstWhere((element) => element.name == contentName);
    return ChangeNotifierProvider(
      create: (BuildContext context) => ContentProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text("Favorites"),
        ),
        body: Container(
          color: Colors.black38,
          child: ListView(
            children: [
              Text(loadedContent.name),
            ],
          ),
        ),
      ),
    );
  }
}