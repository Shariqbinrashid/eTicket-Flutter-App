import 'dart:async';

import 'package:eticket/Colors.dart';
import 'package:eticket/views/userCheck.dart';
import 'package:flutter/material.dart';




class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 4);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => userCheck()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/register.png'), fit: BoxFit.cover),
            ),
          ),
           Center(
            child: Text("Eticket",
              style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: MyColors.yellowColor,

              ),

            ),
          )
        ],
      ),
    );
  }
}
// class AuthenticationWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User?>();
//
//     context.read<AuthenticationService>().signOut();
//     if (firebaseUser != null) {
//       print(firebaseUser);
//       return UserHome();
//     }
//     return userCheck();
//   }
// }