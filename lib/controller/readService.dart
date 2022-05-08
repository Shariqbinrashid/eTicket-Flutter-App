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
  static Future<String> getIdByEventNameAndEmail(String? name,String ?email) async {
    try {
      var data;
      print("check");
      final result = db.collection("tickets").where("userEmail",isEqualTo: email).where("eventName",isEqualTo: name);
      var querySnapshots = await result.get();
      for (var snapshot in querySnapshots.docs) {
        data = snapshot.id; // <-- Document ID
      }


      return data;
    }
    on FirebaseException catch (e) {
      return "1";
    }
  }

  static Future<String> getTicketStaTus(String? name,String ?email) async {
    try {
      var data;
      final result = db.collection("tickets").where("userEmail",isEqualTo: email).where("eventName",isEqualTo: name);
      var querySnapshots = await result.get();

      for (var snapshot in querySnapshots.docs) {
        data = (snapshot.data()["vStatus"]);
        // <-- Document ID
      }


      return data;
    }
    on FirebaseException catch (e) {
      return "2";
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

  static Stream<QuerySnapshot>? readTicketByName(String name){
    try {
      final result = db.collection("tickets").where(
          "eventName", isEqualTo: name).snapshots();
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