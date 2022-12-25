import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/Firebase/auth.dart';

class ProfilePage extends StatefulWidget {

  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "";
  String email = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        centerTitle: true,
        title: FutureBuilder(builder: (context,snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return const Text("loading...");
          }
          return Text(name);
        },future: _fetch(),),
      ),
      body: Container(
        color: Colors.black38,
        child: Column(
          children: [
            FutureBuilder(builder: (context,snapshot){
              if(snapshot.connectionState != ConnectionState.done){
                return const Text("loading...");
              }
              return Text(email);
            },future: _fetch(),),
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
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
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
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
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
              height: 70,
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
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
                        onPressed: null,
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
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
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
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
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

  _fetch() async{
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser.uid)
        .get()
        .then((value) {
          name = value.get('userName');
          email = value.get('email');
        });
  }
}
