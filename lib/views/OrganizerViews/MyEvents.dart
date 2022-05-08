import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../state/userState.dart';

class MyEvents extends StatelessWidget {
  const MyEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(Provider.of<UserModel>(context, listen: false).email),
          Text(Provider.of<UserModel>(context, listen: false).userType),
        ],
      ),
    );
  }
}