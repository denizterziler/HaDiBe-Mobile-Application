import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/Firebase/auth.dart';
import 'package:se_380_project/FirebaseContent/contentDetailFb.dart';
import 'package:se_380_project/FirebaseContent/firebaseSearch.dart';
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
  late Stream<QuerySnapshot> _streamData;
  final Auth _authService = Auth();
  Map<String, dynamic> filterData = {
    "Series": false,
    "Movies": false,
    "Netflix": false,
    "Disney": false,
    "Action": false,
    "Dram": false,
    "Sci_fi": false,
    "Comedy": false,
    "Horror": false,
    "Animation": false
  };

  Future<bool> isFavorite(String contentName) async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid);
    DocumentSnapshot doc = await documentReference.get();
    List favList = doc['favs'];
    if (favList.contains(contentName) == true) {
      return true;
    } else {
      return false;
    }
  }

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
              iconSize: 40,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FirebaseSearch(),
                ));
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              iconSize: 40,
              onPressed: () {
                /*Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FilterBy(),
                ));*/
                _navigateAndDisplayFilters(context);
              },
              icon: const Icon(Icons.filter_list_sharp),
            ),
          ],
        ),
        body: Container(
          color: Colors.black38,
          child: StreamBuilder<QuerySnapshot>(
            stream: _streamData,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return const Text("Some error");
              }
              if (snapshot.hasData) {
                List<Map> items = parseData(snapshot.data);
                return FutureBuilder(
                    future: filterItems(items, filterData),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? buildGridView(snapshot.data)
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    });
                //return buildGridView(items);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }

  GridView buildGridView(List<Map<dynamic, dynamic>> items) {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    return GridView.builder(
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 3.0, right: 3.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2 / 2.2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        Map thisItem = items[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            footer: GridTileBar(
              trailing: Row(
                children: [
                  Text(
                    thisItem['content_rate'].toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Icon(
                    Icons.star,
                    size: 15,
                  ),
                ],
              ),
              leading: StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(firebaseUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return FutureBuilder(
                        future: isFavorite(thisItem['content_name']),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == true) {
                            return IconButton(
                                onPressed: () {
                                  setState(() {
                                    _authService.addToFirebaseFavs(
                                        thisItem['content_name']);
                                  });
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ));
                          } else {
                            return IconButton(
                                onPressed: () {
                                  setState(() {
                                    _authService.addToFirebaseFavs(
                                        thisItem['content_name']);
                                  });
                                },
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ));
                          }
                        });
                  }),
              title: Text(
                thisItem['content_name'],
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.black54,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ContentDetailFb.routeName, arguments: thisItem);
              },
              child: Image.network(
                thisItem['image_url'],
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _navigateAndDisplayFilters(BuildContext context) async {
    final filteredData = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FilterBy()),
    );
    setState(() {
      filterData = filteredData;
    });
  }
  Future<List> Filters() async{
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid);
    DocumentSnapshot doc = await documentReference.get();
    List filters = doc['filters'];
    if(filters.isNotEmpty){
      return filters;
    }
    return [];
  }

  Future<List<Map>> filterItems(
      List<Map> items, Map<String, dynamic> filterData) async {
    List<Map> filteredItems = <Map>[];
    var filters = await Filters();
    if(filters.isEmpty){
      return items;
    }
    for(var filter in filters){
      for(int i = 0 ; i< items.length ; i++){
        if(items[i]['con_type'] == filter || items[i]['content_platform'] == filter || items[i]['con_category'] == filter){
          filteredItems.add(items[i]);
        }
      }
    }
    return filteredItems;
  }
}
