import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  getUser(user,context) async{
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    _firestore.collection('Users').doc(firebaseUser?.uid).set({'name' : user.userName, 'uid' : user.uid});
  }

  Future<User?> createPerson(String name, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await _firestore.collection("Users").doc(user.user!.uid).set({
      'userName': name,
      'email': email,
    });
    return user.user;
  }
}
