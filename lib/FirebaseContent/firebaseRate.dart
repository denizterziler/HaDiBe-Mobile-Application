import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FirebaseRate extends StatefulWidget {
  static const routeName = '/firebase-rate';

  const FirebaseRate({Key? key}) : super(key: key);

  @override
  State<FirebaseRate> createState() => _FirebaseRateState();
}

class _FirebaseRateState extends State<FirebaseRate> {
  late num _total;
  updateRate(content,rate,hadiBe,rateCount) async{
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Contents').doc(content['con_id']);
    documentReference.update({'rate':rate});
    documentReference.update({'hadiBe':hadiBe});
    documentReference.update({'rateCount': rateCount});
  }
  @override
  Widget build(BuildContext context) {
    var content = ModalRoute.of(context)?.settings.arguments as Map;
    _total = content['content_rate'] * content['con_rate_count'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        centerTitle: true,
        title: Text(
          "Rating of ${content['content_name']}",
        ),
      ),
      body: StreamBuilder<Object>(
        stream: FirebaseFirestore.instance.collection('Contents').doc(content['con_id']).snapshots(),
        builder: (context, snapshot) {
          return Container(
            color: Colors.black38,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      "Current rate of ${content['content_name']} is ${content['content_rate'].toStringAsFixed(2)}"),
                  RatingBar.builder(
                      minRating: 1,
                      initialRating: 1,
                      itemCount: 10,
                      itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        setState(() {
                          rating == 10.0 ? content['con_hadiBe']++ : null;
                          content['con_rate_count']++;
                          content['content_rate'] = (_total + rating) / content['con_rate_count'];
                          _total += rating;
                          updateRate(content, content['content_rate'],content['con_hadiBe'],content['con_rate_count']);
                        });
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        width: 300,
                        height: 100,
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            "${content['con_hadiBe']} HaDiBe",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
