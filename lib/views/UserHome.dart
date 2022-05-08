import 'package:eticket/views/UserViews/MyTickets.dart';
import 'package:eticket/views/userCheck.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Colors.dart';
import '../controller/authentication.dart';
import '../state/userState.dart';
import 'UserViews/AllEvents.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Events"),
              Tab(text: "My Tickets"),

            ],
          ),
          title: const Text("User"),
          backgroundColor: MyColors.blueColor,
          actions: [

            PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
                itemBuilder: (context){
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("Logout"),
                    ),

                  ];
                },
                onSelected:(value){
                  if(value == 0){
                    context.read<AuthenticationService>().signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => userCheck()), (_) => false
                    );
                  }
                }
            ),


          ],
        ),

        body:  const TabBarView(
          children: [
            AllEvents(),
            MyTickets()
          ],
        ),
      ),
    );
  }
}
