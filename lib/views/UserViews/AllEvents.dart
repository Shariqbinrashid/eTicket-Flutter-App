import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../Colors.dart';
import '../../controller/readService.dart';
import 'BuyTicket.dart';

class AllEvents extends StatefulWidget {
  const AllEvents({Key? key}) : super(key: key);

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  late final Stream<QuerySnapshot>? events;
  @override
  void initState() {
    // TODO: implement initState

    events=ReadService.readAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<QuerySnapshot>(stream: events,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot>snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong",
                  style: const TextStyle(fontSize: 20),);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    width: 200.0,
                    height: 100.0,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: Colors.grey,
                              enabled: true,
                              child: ListView.builder(
                                itemBuilder: (_, __) =>
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Container(
                                            width: 48.0,
                                            height: 48.0,
                                            color: Colors.white,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Container(
                                                  width: double.infinity,
                                                  height: 8.0,
                                                  color: Colors.white,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 8.0,
                                                  color: Colors.white,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                                ),
                                                Container(
                                                  width: 40.0,
                                                  height: 8.0,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                itemCount: 6,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ));
              }


              final data = snapshot.requireData;
              return ListView.builder(
                  itemCount: data.size,
                  // Text(data.docs[index]['name'])
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            trailing: Text("Ticket Price: Rs:"+data.docs[index]['price']),
                            leading: Icon(
                              Icons.event, color: MyColors.yellowColor,),
                            title: Text(
                              data.docs[index]['name'], style: TextStyle(
                                fontSize: 30),),
                            subtitle: Container(

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.docs[index]['description'],
                                      style: TextStyle(fontSize: 20)),
                                  Row(
                                    children: [
                                      Text("Date: ", style: TextStyle(
                                          fontWeight: FontWeight.bold),),
                                      Text(data.docs[index]['date']),
                                    ],
                                  ),


                                ],
                              ),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('BUY TICKETS'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        BuyTicket(eventDescription:data.docs[index]['description'], eventDate: data.docs[index]['date'], eventName: data.docs[index]['name'], price: data.docs[index]['price'],)),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }

              );
            }
        )
    );
    }
  }
