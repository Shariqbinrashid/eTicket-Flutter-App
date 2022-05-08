
import 'package:eticket/Colors.dart';
import 'package:eticket/controller/writeService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';

import '../../state/userState.dart';


class CreateEvent extends StatelessWidget {
  CreateEvent({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Color.fromARGB(170, 58, 67, 77)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [

                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: nameController,


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
                                labelText: "Event Name",

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
                            controller: descriptionController,
                            maxLines:2,

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
                                labelText: "Description",

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
                            controller: dateController,

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
                                labelText: "Date",

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
                                'Create Event',
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
                                      final response=await WriteService.createEvent(name: nameController.text.trim(), description: descriptionController.text.trim(), date: dateController.text.trim(), email: Provider.of<UserModel>(context, listen: false).email);
                                      if(response=="1"){
                                        Loader.hide();
                                        nameController.text="";
                                        dateController.text="";
                                        descriptionController.text="";
                                        MotionToast.success(
                                          title: const Text(
                                            'Success',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          description: const Text(
                                            'Event Created',
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
