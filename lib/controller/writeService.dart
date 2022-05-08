import 'package:cloud_firestore/cloud_firestore.dart';

class WriteService{
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<String?> addUser({required String email}) async {
    final user = <String, dynamic>{
      "email": email
    };
    try {
      await db.collection("users").add(user);
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static Future<String?> addOrganizer({required String email}) async {
    final org = <String, dynamic>{
      "email": email
    };
    try {
      await db.collection("organizers").add(org);
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static Future<String?> createEvent({required String name,required String description,required String date,required String email}) async {
    final event = <String, dynamic>{
      "name": name,
      "description":description,
      "date":date,
      "organizerEmail":email
    };
    try {
      await db.collection("events").add(event);
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }


}