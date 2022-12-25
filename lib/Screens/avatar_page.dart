import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
 
  const AvatarPage( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? url;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        centerTitle: true,
        title: const Text('Avatar Page'),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context,url);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        color: Colors.black54,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.all(12.0) + const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: FloatingActionButton(
                          heroTag: 1,
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://www.pngarts.com/files/3/Avatar-PNG-High-Quality-Image.png'),
                            radius: 50,
                          ),
                          onPressed: () {
                            url =
                                'https://www.pngarts.com/files/3/Avatar-PNG-High-Quality-Image.png';
                            avatarChanged(context);
                            _setPicture(url!);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: FloatingActionButton(
                          heroTag: 2,
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://www.pngarts.com/files/11/Avatar-PNG-Photo.png'),
                            radius: 50,
                          ),
                          onPressed: () {
                            url =
                                'https://www.pngarts.com/files/11/Avatar-PNG-Photo.png';
                            avatarChanged(context);
                            _setPicture(url!);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: FloatingActionButton(
                          heroTag: 3,
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://www.pngarts.com/files/11/Avatar-PNG-High-Quality-Image.png'),
                            radius: 50,
                          ),
                          onPressed: () {
                            url =
                                'https://www.pngarts.com/files/11/Avatar-PNG-High-Quality-Image.png';
                            avatarChanged(context);
                            _setPicture(url!);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.all(12.0) + const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: FloatingActionButton(
                          heroTag: 4,
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://www.pngarts.com/files/11/Avatar-PNG-Free-Download.png'),
                            radius: 50,
                          ),
                          onPressed: () {
                            url =
                            'https://www.pngarts.com/files/11/Avatar-PNG-Free-Download.png';
                            avatarChanged(context);
                            _setPicture(url!);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: FloatingActionButton(
                          heroTag: 5,
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://www.pngarts.com/files/11/Avatar-Free-PNG-Image.png'),
                            radius: 50,
                          ),
                          onPressed: () {
                            url =
                            'https://www.pngarts.com/files/11/Avatar-Free-PNG-Image.png';
                            avatarChanged(context);
                            _setPicture(url!);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: FloatingActionButton(
                          heroTag: 6,
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://www.pngarts.com/files/11/Avatar-PNG-Image-Background.png'),
                            radius: 50,
                          ),
                          onPressed: () {
                            url =
                            'https://www.pngarts.com/files/11/Avatar-PNG-Image-Background.png';
                            avatarChanged(context);
                            _setPicture(url!);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void avatarChanged(BuildContext context) {
    const snackBar = SnackBar(
      content: Text("Your avatar has been changed")
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  _setPicture(String url) async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid).update({'URL': url});
  }
}
