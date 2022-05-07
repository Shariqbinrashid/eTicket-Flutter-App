
import 'package:eticket/views/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Colors.dart';


class userCheck extends StatelessWidget {
   String userType="";
  userCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)),
        primary: MyColors.yellowColor,
        fixedSize: const Size(200, 70),
        textStyle: TextStyle(fontSize: 20));
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/register.png'), fit: BoxFit.cover),
          ),
        ),
        Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                 style: style,
                  onPressed: (){
                    userType="user";
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  MyLogin(userType: userType)),
                    );
                  },
                  child: const Text('User Login'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: style,
                onPressed: (){
                  userType="organizer";
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MyLogin(userType: userType)),
                  );
                },
                child: const Text('Organizer Login'),
              ),
            ],
          )
        )
      ],


    );
  }
}
