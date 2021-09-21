import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehnuma_mentor/Screens/Mentor/MentorRegister/m-register1.dart';
import 'package:rehnuma_mentor/Screens/Mentor/mlogin/mlogin.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';
import 'package:rehnuma_mentor/services/DBservice.dart';
import 'package:rehnuma_mentor/services/Providers/MentorProvider.dart';
import 'package:rehnuma_mentor/services/auth.dart';

import 'CustomWidgets/Loading.dart';
import 'Screens/Mentor/MentorHome/mentorhome.dart';
import 'Screens/Splashscreen/Accountselection.dart';
import 'models/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loading = true;
  User user;
  onAppStart() async {
   var _user= AuthService().getUser;

    setState(() {
      loading = true;
      user = _user;
    });
    if (user != null) {
      await DBService().getMentorByUid(user.uid).then((value) {
        Provider.of<MentorProvider>(context, listen: false)
            .setCurrentMentor(value);
      });
    } else {
      print("Mentor user id is null");
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 1), () {
      onAppStart();
    });
    // WidgetsBinding.instance.addPostFrameCallback((Duration d) async {

    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : user == null
            ? MentorLogin()
            : MentorHome();
    // return either the Home or Authenticate widget
    // if (loading == true) {
    //   return Loading();
    // } else {
    //   if (user == null) {
    //     return MentorLogin();
    //   } else if (user != null) {
    //     //AuthService().setProvider(user, context);
    //     return MentorHome();
    //   }
    // }
  }
}
