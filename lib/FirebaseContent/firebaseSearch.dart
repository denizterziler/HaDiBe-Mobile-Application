import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/FirebaseContent/contentDetailFb.dart';


class FirebaseSearch extends StatefulWidget {
  static const routeName = '/firebase-search';

  const FirebaseSearch({Key? key}) : super(key: key);

  @override
  State<FirebaseSearch> createState() => _FirebaseSearchState();
}

class _FirebaseSearchState extends State<FirebaseSearch> {
  final controller = TextEditingController();
  final CollectionReference _referenceContents =
      FirebaseFirestore.instance.collection('Contents');
  late Stream<QuerySnapshot> _streamData;
  late List<Map> items;
  String name = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamData = _referenceContents.snapshots();
  }

  List<Map> parseData(QuerySnapshot querySnapshot) {
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    List<Map> listItems = listDocs
        .map((e) => {
      'content_name': e['name'],
      'content_platform': e['platform'],
      'image_url': e['imageUrl'],
      'content_rate': e['rate'],
      'con_category': e['category'],
      'con_description': e['description'],
      'con_hadiBe': e['hadiBe'],
      'con_rate_count': e['rateCount'],
      'con_id': e['id'],
      'con_type': e['type'],
      'con_length': e['length'],
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
          title: const Text("Search Page"),
        ),
        body: Container(
          color: Colors.black38,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                color: Colors.black26,
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
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _streamData,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return (snapshot.connectionState == ConnectionState.waiting)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              items = parseData(snapshot.data);
                              var data = snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                              if (name.isEmpty) {
                                return ListTile(
                                  title: Text(
                                    data['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    data['platform'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        data['rate'].toStringAsFixed(2),
                                        style: const TextStyle(color: Colors.black54,fontSize: 19,fontWeight: FontWeight.bold),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 25,
                                        color: Colors.amber,
                                      ),
                                    ],
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data['imageUrl']),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        ContentDetailFb.routeName,
                                        arguments: items[index]);
                                  },
                                );
                              }
                              if (data['name']
                                  .toString()
                                  .toLowerCase()
                                  .startsWith(name.toLowerCase())) {
                                return ListTile(
                                  title: Text(
                                    data['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    data['platform'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data['imageUrl']),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        ContentDetailFb.routeName,
                                        arguments: items[index]);
                                  },
                                );
                              }
                              return Container();
                            });
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
