import 'package:flutter/material.dart';
import 'package:se_380_project/Screens/search.dart';
import 'package:se_380_project/Widgets/content_grid.dart';
import 'Screens/filter_by.dart';
import 'Screens/menu.dart';

class ListOfContents extends StatelessWidget {
  static const routeName = '/list-of-contents';

  const ListOfContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(.75),
        title: const Text("HaDiBe!"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Menu(),
            ));
          },
          iconSize: 40,
          icon: const Icon(
            Icons.account_box,
          ),
        ),
        actions: [
          IconButton(
            iconSize: 30,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ));
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            iconSize: 40,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FilterBy(),
              ));
            },
            icon: const Icon(Icons.filter_list_sharp),
          ),
        ],
      ),
      body: Container(
        color: Colors.black38,
        child:  const ContentGrid(),
      ),
    );
  }
}
