import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_380_project/Providers/content_provider.dart';
import 'package:se_380_project/Widgets/content_in_list.dart';
import 'package:se_380_project/Widgets/content_in_watch_list.dart';
import 'package:se_380_project/Widgets/watch_list_content_grid.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Watch List"),
      ),
      body: Container(
        color: Colors.black38,
        child: const WatchListContentGrid(),
        /*ListView.builder(
              itemCount: provider.watchList.length,
              itemBuilder: (BuildContext context, int index) {
                return Text("${provider.watchList[index].name}");
              }),*/
      ),
    );

  }
}
