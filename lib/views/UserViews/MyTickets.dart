import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eticket/views/UserViews/TicketQR.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../Colors.dart';
import '../../controller/readService.dart';
import '../../state/userState.dart';

class MyTickets extends StatefulWidget {
  const MyTickets({Key? key}) : super(key: key);

  @override
  State<MyTickets> createState() => _MyTicketsState();
}

class _MyTicketsState extends State<MyTickets> {
  String email="";
  late final Stream<QuerySnapshot>? tickets;
  @override
  void initState() {
    // TODO: implement initState
    email=Provider.of<UserModel>(context, listen: false).email;
    tickets=ReadService.readTicket(email);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<QuerySnapshot>(stream: tickets,
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
                              Icons.sticky_note_2_outlined, color: MyColors.yellowColor,),
                            title: Text(
                              data.docs[index]['eventName'], style: TextStyle(
                                fontSize: 30),),
                            subtitle: Container(

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.docs[index]['eventDescription'],
                                      style: TextStyle(fontSize: 20)),
                                  Row(
                                    children: [
                                      Text("Date: ", style: TextStyle(
                                          fontWeight: FontWeight.bold),),
                                      Text(data.docs[index]['date']),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("Approval Status: "),
                                  data.docs[index]['bStatus']=="false"?Row(
                                    children: const [
                                      Icon(Icons.pending),
                                      Text("Pending")
                                    ],
                                  ):Row(
                                    children: const [
                                      Icon(Icons.check),
                                      Text("Approved")
                                    ],
                                  ),
                                  Text("Checkin Status: "),
                                  data.docs[index]['vStatus']=="false"?Row(
                                    children: const [


                                      Text("Pending"),
                                      Icon(Icons.pending),

                                    ],
                                  ):Row(
                                    children: const [

                                      Text("Approved"),
                                      Icon(Icons.check)
                                    ],
                                  )

                                ],
                              ),
                            ),
                          ),

                          data.docs[index]['bStatus']=="true"?Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('See Qr Code'),
                                onPressed: () {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                        TicketQr(name: data.docs[index]["eventName"]),
                                  ));

                                },
                              ),
                            ],
                          ):Container()



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
