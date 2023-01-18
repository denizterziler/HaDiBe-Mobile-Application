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
                    /*child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${"Content: " + _userComments[index]['name']}\n Your Comment: " + _userComments[index]['commentText']),
                    ),*/
                  ),
                  const Divider(color: Colors.blueGrey,),
                ],
              );
            },
          )
              : const Text("You haven't made any comments yet.")
              : const Text("Please wait, loading..."),
        ),
      ),
    );
  }
}

