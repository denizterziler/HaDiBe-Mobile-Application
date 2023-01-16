import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/Screens/search.dart';
import 'package:se_380_project/Widgets/content_grid.dart';
import 'Screens/filter_by.dart';
import 'Screens/menu.dart';

class ListOfContents extends StatefulWidget {
  static const routeName = '/list-of-contents';

  ListOfContents({Key? key}) : super(key: key);

  @override
  State<ListOfContents> createState() => _ListOfContentsState();
}

class _ListOfContentsState extends State<ListOfContents> {
  final CollectionReference _referenceContents =
      FirebaseFirestore.instance.collection('Contents');
  late Future<QuerySnapshot> _futureData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureData = _referenceContents.get();
    /*_futureData.then((value) {
      setState(() {
        _items = parseData(value);
      });
    });*/
  }

  List<Map> parseData(QuerySnapshot querySnapshot) {
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    List<Map> listItems = listDocs
        .map((e) => {
              'content_name': e['name'],
              'content_platform': e['platform'],
              'image_url': e['imageUrl'],
              'content_rate':e['rate'],
            })
        .toList();
    return listItems;
  }

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
        /*body: Container(
        color: Colors.black38,
        child:  const ContentGrid(),
      ),*/
        body: Container(
          color: Colors.black38,
          child: FutureBuilder<QuerySnapshot>(
            future: _futureData,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return const Text("Some error");
              }
              if (snapshot.hasData) {
                List<Map> items = parseData(snapshot.data);
                //return buildListView(items);
                return buildGridView(items);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }

  GridView buildGridView(List<Map<dynamic, dynamic>> items) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        Map thisItem = items[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            footer: GridTileBar(
              trailing: Row(
                children: [
                  Text(thisItem['content_rate'].toString(),style: const TextStyle(color: Colors.white),),
                  const Icon(
                    Icons.star,
                    size: 9,
                  ),
                ],
              ),
              title: Text(thisItem['content_name']),
              backgroundColor: Colors.black54,
            ),
            child: Image.network(
              thisItem['image_url'],
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  ListView buildListView(List<Map<dynamic, dynamic>> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        Map thisItem = items[index];
        return ListTile(
          leading: Image.network(thisItem['image_url']),
          title: Text(thisItem['content_name']),
          subtitle: Text(thisItem['content_platform']),
        );
      },
    );
  }
}
