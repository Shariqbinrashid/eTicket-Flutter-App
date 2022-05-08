import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../Colors.dart';
import '../../state/userState.dart';

class TicketQr extends StatelessWidget {
  const TicketQr({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ticket QR"),backgroundColor: MyColors.blueColor,),
      body: Center(
        child: QrImage
          (data: name+Provider.of<UserModel>(context, listen: false).email,

        ),
      ),

    );
  }
}
