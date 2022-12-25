import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        centerTitle: true,
        title: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Text("loading...");
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
            /*FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Text("loading...");
                }
                return Text(email);
              },
              future: _fetch(),
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                builder: (context,snapshot){
                  if (snapshot.connectionState != ConnectionState.done){
                    return const Text("Image Loading..");
                  }
                  return CircleAvatar(
                    radius: 55,
                    backgroundImage: url == "" ? const NetworkImage("https://www.clipartmax.com/png/middle/437-4374952_no-avatar-male-female.png") : NetworkImage(url),
                  );
                },
                future: _fetch(),
              ),
              /*CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(url),
              ),*/
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
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
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
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 180,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.amber)),
                        onPressed: null,
                        child: const Text("Favorite Movie"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 180,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.amber)),
                        onPressed: null,
                        child: const Text("Favorite Series"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
    setState(() => url = imageUrl);
  }
}
