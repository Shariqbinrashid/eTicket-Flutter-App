

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

  static Future<String?> createEvent({required String name,required String description,required String date,required String email,required String price}) async {
    final event = <String, dynamic>{
      "name": name,
      "description":description,
      "date":date,
      "organizerEmail":email,
      "price":price
    };
    try {
      await db.collection("events").add(event);
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static Future<String?> buyTicket({required String username,required String trasactionId,required String userBank,required String userEmail,required String Eventprice,required String eventName,required String eventDescription,required String eventDate}) async {
    final ticket = <String, dynamic>{
      "userName": username,
      "eventDescription":eventDescription,
      "date":eventDate,
      "userEmail":userEmail,
      "price":Eventprice,
      "transactionID":trasactionId,
      "eventName":eventName,
      "vStatus":"false",
      "bStatus":"false"
    };
    try {
      await db.collection("tickets").add(ticket);
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static  Future<String?> approvePayment(String id)async{
    try {
      
      
       db.collection("tickets").doc(id).update({"bStatus":"true"});
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static  Future<String?> approveTicket(String id)async{
    try {


      db.collection("tickets").doc(id).update({"vStatus":"true"});
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
  static  Future<String?> declinePayment(String id)async{
    try {


      db.collection("tickets").doc(id).update({"bStatus":"false"});
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

}