import 'package:flutter/material.dart';
import 'package:se_380_project/Widgets/watch_list_content_grid.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        centerTitle: true,
        title: const Text("Watch List"),
      ),
      body: Container(
        color: Colors.black38,
        child: const WatchListContentGrid(),
      ),
    );

  }
}
