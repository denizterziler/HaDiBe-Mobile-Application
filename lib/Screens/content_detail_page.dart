import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_380_project/Providers/content_provider.dart';

class ContentDetailPage extends StatelessWidget {
  static const routeName = '/content-detail';

  const ContentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contentName = ModalRoute.of(context)?.settings.arguments as String;
    final loadedContent = Provider.of<ContentProvider>(context)
        .items
        .firstWhere((element) => element.name == contentName);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(loadedContent.name),
      ),
      body: ListView(
        children: [
          Center(
            child: Image.network(loadedContent.imageUrl),
          ),
          Padding(
            padding:
                const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  color: Colors.orange,
                  child: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        const WidgetSpan(
                            child: Icon(
                              Icons.star,
                              color: Colors.blue,
                              size: 30,
                            )),
                        TextSpan(
                          text: 'Rate of ${loadedContent.name} is:${loadedContent.rate}/10',
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                Container(
                  color: Colors.pink,
                  child: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        const WidgetSpan(
                            child: Icon(
                          Icons.info_outline,
                          color: Colors.blue,
                          size: 30,
                        )),
                        TextSpan(
                          text: 'Available on ${loadedContent.platform}',
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                Text(
                  "Description of ${loadedContent.name}",
                  style: const TextStyle(fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(loadedContent.description),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: const [
                Expanded(
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text("Comment"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text("Rate"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text("+ List"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text("Other"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
