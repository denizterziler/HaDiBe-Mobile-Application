import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_380_project/Models/content.dart';
import 'package:se_380_project/Providers/content_provider.dart';
import 'package:se_380_project/Screens/content_detail_page.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  List<Content> listOfContent = ContentProvider().items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Search Page"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.black38,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Content Name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.amber),
                  )),
              onChanged: searchContent,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.black38,
              child: ListView.separated(
                itemCount: listOfContent.length,
                itemBuilder: (context, index) {
                  final content = listOfContent[index];
                  return ListTile(
                    leading: Image.network(
                      content.imageUrl,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                    title: Text(
                      content.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(ContentDetailPage.routeName,
                          arguments: content.name);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.amber,
                    height: 10,
                    thickness: 2,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void searchContent(String value) {
    final searched = ContentProvider().items.where((element) {
      final contentName = element.name.toLowerCase();
      final input = value.toLowerCase();
      return contentName.contains(input);
    }).toList();
    setState(() {
      listOfContent = searched;
    });
  }
}
