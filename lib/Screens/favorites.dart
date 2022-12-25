import 'package:flutter/material.dart';
import 'package:se_380_project/Widgets/favorites_content_grid.dart';
class Favorites extends StatefulWidget {
  static const routeName = '/favorites';

  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        centerTitle: true,
        title: const Text("Favorites"),
      ),
      body: Container(
        color: Colors.black38,
        child: const FavoritesContentGrid(),
      ),
    );
  }
}