import 'package:flutter/material.dart';
import 'package:se_380_project/Widgets/content_grid.dart';
import 'Screens/filter_by.dart';
import 'Screens/menu.dart';

class ListOfContents extends StatelessWidget {
  const ListOfContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text("HaDiBe!")),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Menu(),
            ));
          },
          iconSize: 40,
          icon: const Icon(
            Icons.account_box,
          ),
        ),
        actions: [
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
        child:  ContentGrid(),
      ),
    );
  }
}
