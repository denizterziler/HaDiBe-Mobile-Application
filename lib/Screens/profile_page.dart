import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/FirebaseContent/favMovieAndSerie.dart';
import 'package:se_380_project/FirebaseContent/otherUsers.dart';
import 'package:se_380_project/Screens/avatar_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "";
  String email = "";
  String url = "";
  String password = "";
  String favMovie = "";
  final CollectionReference _referenceContents =
      FirebaseFirestore.instance.collection('Contents');
  late Stream<QuerySnapshot> _streamData;

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

  void initState() {
    // TODO: implement initState
    super.initState();
    _streamData = _referenceContents.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        centerTitle: true,
        title: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Text("Loading...");
            }
            return Text(name);
          },
          future: _fetch(),
        ),
      ),
      body: Container(
        color: Colors.black38,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Text("Image Loading...");
                  }
                  return CircleAvatar(
                    radius: 55,
                    backgroundImage: url == ""
                        ? const NetworkImage(
                            "https://www.clipartmax.com/png/middle/437-4374952_no-avatar-male-female.png")
                        : NetworkImage(url),
                  );
                },
                future: _fetch(),
              ),
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text("5 Follower"),
                          ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.amber)),
                            onPressed: null,
                            label: const Text("Followers"),
                            icon: const Icon(Icons.supervisor_account_rounded),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text("7 Follows"),
                          ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.amber)),
                            onPressed: null,
                            label: const Text("Follows"),
                            icon: const Icon(Icons.supervisor_account_rounded),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(firebaseUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Text("Loading...");
                        }
                        return Container(
                            color: Colors.redAccent,
                            height: 45,
                            child: Center(
                                child: Text(
                              "All Time Favorite:  $favMovie",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )));
                      },
                      future: _fetch(),
                    );
                  }),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 70,
                    width: 180,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.amber)),
                      onPressed: () {
                        _navigateAndDisplayAvatars(context);
                      },
                      child: const Text("Change Avatar"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 70,
                    width: 180,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.amber)),
                      onPressed: () {
                        _navigateAndDisplayMoviesAndSeries(context);
                      },
                      child: const Text("All Times Favorite"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 70,
                    width: 180,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.amber)),
                      onPressed: () {
                        _navigateAndDisplayOtherUsers(context);
                      },
                      child: const Text("Other Users"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _navigateAndDisplayOtherUsers(context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const OtherUsers()));
  }

  _navigateAndDisplayMoviesAndSeries(context) async {
    final favoriteMovie = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AllTimeFavorite()),
    );
    setState(() {
      favMovie = favoriteMovie;
    });
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser.uid)
        .get()
        .then((value) {
      name = value.get('userName');
      email = value.get('email');
      url = value.get('URL');
      password = value.get('password');
      favMovie = value.get('allTimeFavorite');
    });
  }

  Future<void> _navigateAndDisplayAvatars(BuildContext context) async {
    final imageUrl = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AvatarPage()),
    );
    updateImage(imageUrl);
  }

  void updateImage(String imageUrl) {
    setState(() {
      url = imageUrl;
    });
  }
}
