

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';

import '../../Colors.dart';
import '../../controller/writeService.dart';
import '../../state/userState.dart';

class BuyTicket extends StatelessWidget {
  final String eventName;
  final String eventDate;
  final String eventDescription;
  final String price;
  BuyTicket({Key? key, required this.eventName, required this.eventDate, required this.eventDescription, required this.price}) : super(key: key);

  final TextEditingController nameCont = TextEditingController();
  final TextEditingController trasCont = TextEditingController();
  final TextEditingController bankCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text("Buy Ticket"),backgroundColor: MyColors.blueColor,),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 35, top: 30),
                      child: Text(
                        'Event Details',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                        Card(
                          color: MyColors.blueColor,
                        child: Column(
                        mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              trailing: Text("Ticket Price: Rs:"+price),
                              leading: Icon(
                                Icons.event, color: MyColors.greyColor,),
                              title: Text(
                                eventName, style: TextStyle(
                                  fontSize: 30),),
                              subtitle: Container(

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(eventDescription,
                                        style: TextStyle(fontSize: 20)),
                                    Row(
                                      children: [
                                        Text("Event Date: ", style: TextStyle(
                                            fontWeight: FontWeight.bold),),
                                        Text(eventDate),
                                      ],
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [

                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: nameCont,


                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                labelText: "Your Name",

                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: trasCont,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                labelText: "Transaction ID",

                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: bankCon,

                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                labelText: "Your Bank: ",

                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Buy Ticket',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: MyColors.yellowColor,
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () async{

                                      Loader.show(context,progressIndicator:CircularProgressIndicator());
                                      final response=await WriteService.buyTicket(username: nameCont.text.trim(), trasactionId: trasCont.text.trim(), userBank: bankCon.text.trim(), userEmail: Provider.of<UserModel>(context, listen: false).email, Eventprice: price, eventName: eventName, eventDescription: eventDescription, eventDate: eventDate);

                                      if(response=="1"){
                                        Loader.hide();
                                        nameCont.text="";
                                        trasCont.text="";
                                        bankCon.text="";
                                        MotionToast.success(
                                          title: const Text(
                                            'Success',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          description: const Text(
                                            'Ticket Purchased',
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
                                          description: const Text('Something wen wrong'),
                                          animationType: ANIMATION.fromLeft,
                                          position: MOTION_TOAST_POSITION.top,
                                          barrierColor: Colors.black.withOpacity(0.3),
                                          width: 300,
                                          dismissable: true,
                                        ).show(context);

                                      }

                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),


                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
