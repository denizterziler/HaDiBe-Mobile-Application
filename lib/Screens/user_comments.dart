import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class UserComments extends StatefulWidget {
  @override
  State<UserComments> createState() => _UserCommentsState();
}

class _UserCommentsState extends State<UserComments> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _username;
  List<Map<String, dynamic>> _userComments = [];


  @override
  void initState() {
    super.initState();
  }

  _getUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    final value = await FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser.uid)
        .get();
    _username = value.get('userName');
    _getUserComments();
  }


  _getUserComments() async {
    if (_username != null && _username.isNotEmpty) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Comments')
          .where('authorComment', isEqualTo: _username)
          .get();
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _userComments = snapshot.docs.map((doc) =>
          {"name":doc['name'], "commentText":doc['commentText']}
          ).toList();
        });


      }
    }
  }
  @override
  Widget build(BuildContext context) {
    _getUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        centerTitle: true,
        title: const Text("My Comments"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.black12,
        child: Center(
          child: _username != null
              ? _userComments.isNotEmpty
              ? ListView.builder(
            itemCount: _userComments.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    subtitle: Text("${_userComments[index]['name']}"),
                    title: Text("Comment: ${_userComments[index]['commentText']}"),
                  ),
                  const Divider(color: Colors.blueGrey,),
                ],
              );
            },
          )
              : const Center(child: CircularProgressIndicator())
              : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        width: 350,
                        height: 50,
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            "You don't have any comments",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        width: 300,
                        height: 100,
                        color: Colors.red,
                        child: const Center(
                          child: Text(
                            "You can make comments from Content Detail Page",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

