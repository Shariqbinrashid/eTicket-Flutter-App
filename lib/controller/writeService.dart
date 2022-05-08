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


}