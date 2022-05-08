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

  static Stream<QuerySnapshot>? readTicket(String email){
    try {
      final result = db.collection("tickets").where(
          "userEmail", isEqualTo: email).snapshots();
      return result;
    }
    on FirebaseException catch (e) {
      return null;
    }
  }

  static Stream<QuerySnapshot>? readAllEvents(){
    try {
      final result = db.collection("events").snapshots();
      return result;
    }
    on FirebaseException catch (e) {
      return null;
    }
  }
}