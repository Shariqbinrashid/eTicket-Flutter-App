import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eticket/controller/writeService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shimmer/shimmer.dart';

import '../../Colors.dart';
import '../../controller/readService.dart';

class PendingTickets extends StatefulWidget {
  final String eventName;
  const PendingTickets({Key? key, required this.eventName}) : super(key: key);

  @override
  State<PendingTickets> createState() => _PendingTicketsState();
}

class _PendingTicketsState extends State<PendingTickets> {
  late final Stream<QuerySnapshot>? tickets;



  @override
  void initState() {
    // TODO: implement initState
    tickets=ReadService.readTicketByName(widget.eventName);
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
                    return  data.docs[index]['bStatus']=="false"?Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(

                            leading: Icon(
                              Icons.sticky_note_2_outlined, color: MyColors.yellowColor,),
                            title: Text(
                              data.docs[index]['userEmail'], style: TextStyle(
                                fontSize: 20),),
                            subtitle: Container(

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Transaction ID:"),
                                  Text(data.docs[index]['transactionID']),
                                  Text("User Name:"),
                                  Text(data.docs[index]['userName']),
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

                          data.docs[index]['bStatus']=="false"?Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('Approve'),
                                onPressed: () async{
                                  Loader.show(context,progressIndicator:CircularProgressIndicator());
                                  final eventid=await ReadService.getIdByEventNameAndEmail(widget.eventName, data.docs[index]['userEmail']);
                                  if(eventid!='1'){
                                    final response =await WriteService.approvePayment(eventid);
                                    if(response=="1"){
                                      Loader.hide();
                                      MotionToast.success(
                                        title: const Text(
                                          'Success',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        description: const Text(
                                          'Approved',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        layoutOrientation: ORIENTATION.rtl,
                                        animationType: ANIMATION.fromRight,
                                        dismissable: true,
                                        width: 300,
                                      ).show(context);
                                    }else{
                                      Loader.hide();
                                      MotionToast.error(
                                        title: const Text(
                                          'Error',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        description: const Text('Something went wrong'),
                                        animationType: ANIMATION.fromLeft,
                                        position: MOTION_TOAST_POSITION.top,
                                        barrierColor: Colors.black.withOpacity(0.3),
                                        width: 300,
                                        dismissable: true,
                                      ).show(context);
                                    }
                                  }else {
                                    Loader.hide();
                                    MotionToast.error(
                                      title: const Text(
                                        'Error',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      description: const Text('Something went wrong'),
                                      animationType: ANIMATION.fromLeft,
                                      position: MOTION_TOAST_POSITION.top,
                                      barrierColor: Colors.black.withOpacity(0.3),
                                      width: 300,
                                      dismissable: true,
                                    ).show(context);
                                  }
                                },
                              ),
                            ],
                          ):Container()



                        ],
                      ),
                    ):Container();
                  }

              );
            }
        )
    );
  }
}
