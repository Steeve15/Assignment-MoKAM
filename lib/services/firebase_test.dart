import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  Future<void> ping() async {
    await db.collection('meta').doc('ping').set({
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
