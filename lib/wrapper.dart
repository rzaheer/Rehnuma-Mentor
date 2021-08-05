import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CustomWidgets/Loading.dart';
import 'Screens/Mentor/MentorHome/mentorhome.dart';
import 'Screens/Splashscreen/Accountselection.dart';
import 'models/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loading = false;
  onAppStart() async {
    setState(() {
      loading = true;
    });

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onAppStart();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    // return either the Home or Authenticate widget
    if (loading == true) {
      return Loading();
    } else {
      if (user == null) {
        return AccountSelection();
      } else if (user != null) {
        // AuthService().setProvider(user, context);
        return MentorHome();
      }
    }
  }
}
