

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eticket/views/OrganizerViews/Approved.dart';
import 'package:eticket/views/OrganizerViews/Pending.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Colors.dart';
import '../../controller/readService.dart';
import 'QrScanner.dart';

class EventPage extends StatefulWidget {
 final String eventName;
  const EventPage({Key? key, required this.eventName}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {


  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Approved"),
              Tab(text: "Pending"),
              Tab(text: "Scan"),

            ],
          ),
          title: const Text("Event Tickets Buyers"),
          backgroundColor: MyColors.blueColor,
        ),

        body: TabBarView(
          children: [
             ApprovedTickets(eventName: widget.eventName,),
             PendingTickets(eventName: widget.eventName,),
            QRViewExample()

          ],
        ),
      ),
    );
  }
}
