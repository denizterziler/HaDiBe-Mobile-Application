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
        color: Colors.black38,
        child: Center(
          child: SingleChildScrollView(
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
                                  'https://w7.pngwing.com/pngs/555/703/png-transparent-computer-icons-avatar-woman-user-avatar-face-heroes-service-thumbnail.png'),
                              radius: 50,
                            ),
                            onPressed: () {
                              url =
                              'https://w7.pngwing.com/pngs/555/703/png-transparent-computer-icons-avatar-woman-user-avatar-face-heroes-service-thumbnail.png';
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
                                  'https://w7.pngwing.com/pngs/122/453/png-transparent-computer-icons-user-profile-avatar-female-profile-heroes-head-woman-thumbnail.png'),
                              radius: 50,
                            ),
                            onPressed: () {
                              url =
                              'https://w7.pngwing.com/pngs/122/453/png-transparent-computer-icons-user-profile-avatar-female-profile-heroes-head-woman-thumbnail.png';
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
                                  'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon-thumbnail.png'),
                              radius: 50,
                            ),
                            onPressed: () {
                              url =
                              'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon-thumbnail.png';
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
                                  'https://w7.pngwing.com/pngs/78/788/png-transparent-computer-icons-avatar-business-computer-software-user-avatar-child-face-hand-thumbnail.png'),
                              radius: 50,
                            ),
                            onPressed: () {
                              url =
                              'https://w7.pngwing.com/pngs/78/788/png-transparent-computer-icons-avatar-business-computer-software-user-avatar-child-face-hand-thumbnail.png';
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
                                  'https://w7.pngwing.com/pngs/710/723/png-transparent-digital-marketing-computer-icons-technical-support-user-avatar-avatar-child-face-heroes-thumbnail.png'),
                              radius: 50,
                            ),
                            onPressed: () {
                              url =
                              'https://w7.pngwing.com/pngs/710/723/png-transparent-digital-marketing-computer-icons-technical-support-user-avatar-avatar-child-face-heroes-thumbnail.png';
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
                                  'https://w7.pngwing.com/pngs/238/446/png-transparent-computer-icons-user-profile-avatar-old-man-face-heroes-head-thumbnail.png'),
                              radius: 50,
                            ),
                            onPressed: () {
                              url =
                              'https://w7.pngwing.com/pngs/238/446/png-transparent-computer-icons-user-profile-avatar-old-man-face-heroes-head-thumbnail.png';
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
                                  'https://w7.pngwing.com/pngs/228/419/png-transparent-the-matrix-agent-smith-trinity-the-oracle-neo-others-miscellaneous-face-orange.png'),
                              radius: 50,
                            ),
                            onPressed: () {
                              url =
                              'https://w7.pngwing.com/pngs/228/419/png-transparent-the-matrix-agent-smith-trinity-the-oracle-neo-others-miscellaneous-face-orange.png';
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
                                  'https://w7.pngwing.com/pngs/382/121/png-transparent-morpheus-computer-icons-the-matrix-miscellaneous-purple-angle.png'),
                              radius: 50,
                            ),
                            onPressed: () {
                              url =
                              'https://w7.pngwing.com/pngs/382/121/png-transparent-morpheus-computer-icons-the-matrix-miscellaneous-purple-angle.png';
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
                                  'https://play-lh.googleusercontent.com/7XUn13_eyh3Xg92JKh_nYsQ0LwmBvFdX1lfl15L2ioUK2Ds_MC5nEwBhSiM-GHEYfro'),
                              radius: 50,
                            ),
                            onPressed: () {
                              url =
                              'https://play-lh.googleusercontent.com/7XUn13_eyh3Xg92JKh_nYsQ0LwmBvFdX1lfl15L2ioUK2Ds_MC5nEwBhSiM-GHEYfro';
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
