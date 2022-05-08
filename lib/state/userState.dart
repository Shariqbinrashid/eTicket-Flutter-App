import 'package:flutter/cupertino.dart';

class UserModel with ChangeNotifier {
  UserModel({required this.email,required this.userType});

  String email;
  String userType;

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }
  void setUserType(String type) {
    this.userType = type;
    notifyListeners();
  }

}