import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OtherUsers extends StatefulWidget {
  const OtherUsers({super.key});

  @override
  State<OtherUsers> createState() => _OtherUsersState();
}

class _OtherUsersState extends State<OtherUsers> {
  final CollectionReference _referenceContents =
  FirebaseFirestore.instance.collection('Users');
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
          title: const Text('Other Users'),
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
                        data['userName'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        data['allTimeFavorite'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),

                      leading: CircleAvatar(
                        backgroundImage:
                        NetworkImage(data['URL']),
                      ),
                      onTap: (){
                      },
                    );
                    return Container();
                  });
            },
          ),
        )
    );
  }

}
