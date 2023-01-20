import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AllTimeFavorite extends StatefulWidget {
  const AllTimeFavorite({super.key});

  @override
  State<AllTimeFavorite> createState() => _AllTimeFavoriteState();
}

class _AllTimeFavoriteState extends State<AllTimeFavorite> {
  final CollectionReference _referenceContents =
  FirebaseFirestore.instance.collection('Contents');
  late Stream<QuerySnapshot> _streamData;
  void initState() {
    super.initState();
    _streamData = _referenceContents.snapshots();
  }
  @override
  Widget build(BuildContext context) {
    String? name;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        centerTitle: true,
        title: const Text('All Times Favorite'),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context,name);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body:Container(
        color: Colors.black38,
        child: StreamBuilder<QuerySnapshot>(
          stream: _streamData,
          builder:
              (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index].data()
                  as Map<String, dynamic>;
                    return ListTile(
                      title: Text(
                        data['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        data['platform'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data['rate'].toStringAsFixed(2),
                            style: const TextStyle(color: Colors.black54,fontSize: 19,fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.star,
                            size: 25,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                      leading: CircleAvatar(
                        backgroundImage:
                        NetworkImage(data['imageUrl']),
                      ),
                      onTap: (){
                        name = data['name'];
                        favoriteChanged(context);
                        _setFavorite(data['name']);
                      },

                    );

                  return Container();
                });
          },
        ),
      )
    );
  }

  void favoriteChanged(BuildContext context) {
    const snackBar = SnackBar(
        content: Text("Your favorite has been changed")
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _setFavorite(String name) async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid).update({'allTimeFavorite': name});
  }
}
