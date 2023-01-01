import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_380_project/Providers/content_provider.dart';
import 'package:se_380_project/Widgets/content_in_list.dart';

class ContentGrid extends StatelessWidget {
  const ContentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final contentData = Provider.of<ContentProvider>(context);
    //final contents = contentData.items;
    final contents = contentData.sort(contentData.items);
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: contents.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: contents[index],
        child: const ContentInList(),
      ),
    );
  }
}
