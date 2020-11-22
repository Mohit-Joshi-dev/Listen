import 'package:Alarm/Models/music.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Music>> getMusic() {
    return _db
        .collection('music')
        .snapshots()
        .map((s) => s.docs.map((docs) => Music.fromJson(docs.data())).toList());
  }
}
