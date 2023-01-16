import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/Models/content.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }

  getUser(user, context) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    _firestore
        .collection('Users')
        .doc(firebaseUser?.uid)
        .set({'name': user.userName, 'uid': user.uid});
  }

  Future<User?> createPerson(String name, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await _firestore.collection("Users").doc(user.user!.uid).set({
      'userName': name,
      'email': email,
      'URL': "",
      'password': password,
      'favs': [],
      'watchList': [],
    });
    return user.user;
  }

  addToFirebaseFavs(String contentName) async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid);
    DocumentSnapshot doc = await documentReference.get();
    List favs = doc['favs'];
    if (favs.contains(contentName) == true) {
      documentReference.update({
        'favs': FieldValue.arrayRemove([contentName])
      });
    } else {
      documentReference.update({
        'favs': FieldValue.arrayUnion([contentName])
      });
    }
  }

  addToFirebaseWatchList(String contentName) async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid);
    DocumentSnapshot doc = await documentReference.get();
    List watchList = doc['watchList'];
    if (watchList.contains(contentName) == true) {
      documentReference.update({
        'watchList': FieldValue.arrayRemove([contentName])
      });
    } else {
      documentReference.update({
        'watchList': FieldValue.arrayUnion([contentName])
      });
    }
  }

  getFavorites() async {
    List<Content> favContents = [];
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid);
    DocumentSnapshot doc = await documentReference.get();
    List favNames = doc['favs'];
  }

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
}
