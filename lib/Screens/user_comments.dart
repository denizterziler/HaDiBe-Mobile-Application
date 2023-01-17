import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class UserComments extends StatefulWidget {
  @override
  State<UserComments> createState() => _UserCommentsState();
}

class _UserCommentsState extends State<UserComments> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _user;
  List<String> _userComments = [];

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  _getUser() async {
    _user = await FirebaseAuth.instance.currentUser;
    _getUserComments();
  }

  _getUserComments() async {
    if (_user != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('comments')
          .where('authorComment', isEqualTo: _user.email)
          .get();
      if(snapshot.docs.isNotEmpty){
        setState(() {
          _userComments = snapshot.docs.map((doc) => doc['commentText']).cast<String>().toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: _user != null
              ? _userComments.isNotEmpty
              ? ListView.builder(
            itemCount: _userComments.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_userComments[index]),
                ),
              );
            },
          )
              : Text("You haven't made any comments yet.")
              : Text("Please wait, loading..."),
        ),
      ),
    );
  }
}

