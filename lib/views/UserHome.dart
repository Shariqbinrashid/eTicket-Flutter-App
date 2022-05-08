import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/userState.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hdhd"),
      ),
      body: Container(
        child: Column(
          children: [
            Text(Provider.of<UserModel>(context, listen: false).email),
            Text(Provider.of<UserModel>(context, listen: false).userType),
          ],
        ),
      ),
    );
  }
}
