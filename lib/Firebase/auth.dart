import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {

    UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }

  getUser(user, context) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
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
      'URL': "https://www.clipartmax.com/png/middle/437-4374952_no-avatar-male-female.png",
      'password': password,
      'favs': [],
      'watchList': [],
      'allTimeFavorite' : "Not Decided Yet",
      'filters': [],
      'likedCT' : [],
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
  addToFirebaseFilters(Iterable <String> filters) async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid);
    for(var filterName in filters){
      documentReference.update({
        'filters': FieldValue.arrayUnion([filterName])
      });
    }
  }
  addToFirebaseLiked(String commentText) async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid);
    DocumentSnapshot doc = await documentReference.get();
    List likedComments = doc['likedCT'];
    if (likedComments.contains(commentText) == true) {
      documentReference.update({
        'likedCT': FieldValue.arrayRemove([commentText])
      });
    } else {
      documentReference.update({
        'likedCT': FieldValue.arrayUnion([commentText])
      });
    }
  }
  FirebaseFiltersList(String filterName) async{
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid);
    DocumentSnapshot doc = await documentReference.get();
    List filterList = doc['filters'];
    if(filterList.contains(filterName)){
      documentReference.update({
        'filters': FieldValue.arrayRemove([filterName])
      });
    }
    else{
      documentReference.update({
        'filters': FieldValue.arrayUnion([filterName])
      });
    }

  }
  resetFilters() async{
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid);
    DocumentSnapshot doc = await documentReference.get();
    List filters = doc['filters'];
    for(var filter in filters){
      documentReference.update({
        'filters': FieldValue.arrayRemove([filter])
      });
    }
  }
}

