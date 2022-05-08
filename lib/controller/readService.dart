import 'package:cloud_firestore/cloud_firestore.dart';

class ReadService{
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot>? readEvents(String email){
    try {
      final result = db.collection("events").where(
          "organizerEmail", isEqualTo: email).snapshots();
      return result;
    }
    on FirebaseException catch (e) {
      return null;
    }
  }
}