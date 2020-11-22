import 'package:Alarm/Models/loops.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServiceLoops {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Loops>> getLoops() {
    return _db
        .collection("loops")
        .orderBy("name", descending: true)
        .snapshots()
        .map((s) => s.docs.map((docs) => Loops.fromJson(docs.data())).toList());
  }
}
