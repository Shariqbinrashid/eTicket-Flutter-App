import 'package:eticket/Colors.dart';
import 'package:eticket/views/login.dart';
import 'package:eticket/views/userCheck.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/authentication.dart';
import '../state/userState.dart';
import 'OrganizerViews/MyEvents.dart';

class OrganizerHome extends StatefulWidget {
  const OrganizerHome({Key? key}) : super(key: key);

  @override
  State<OrganizerHome> createState() => _OrganizerHomeState();
}

class _OrganizerHomeState extends State<OrganizerHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "My Events"),
              Tab(text: "Create Events"),

            ],
          ),
          title: const Text("Organizer"),
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

        body: const TabBarView(
          children: [
            MyEvents(),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}


