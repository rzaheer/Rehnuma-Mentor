import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rehnuma_mentor/Screens/Mentor/MentorHome/AvailableSlot/Availableslots.dart';
import 'package:rehnuma_mentor/Screens/Mentor/MentorHome/DocProfile/DocProfile.dart';
import 'package:rehnuma_mentor/Screens/Mentor/MentorHome/notifs.dart';
import 'package:rehnuma_mentor/Screens/Mentor/mlogin/mlogin.dart';
import 'package:rehnuma_mentor/Screens/chatScreens/allChtas.dart';
import 'package:rehnuma_mentor/SharedFunctions.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';
import 'package:rehnuma_mentor/services/auth.dart';

import '../../../Global.dart';
import '../../../services/Providers/MentorProvider.dart';
import 'DrawerItems/About.dart';
import 'DrawerItems/Accountsettings.dart';
import 'DrawerItems/Earningdetails.dart';
import 'DrawerItems/Termsandcond.dart';
import 'MentorPastAppointments.dart/MentorPastApp.dart';
import 'Mentorscheduledapp.dart/mentorscheduleapp.dart';

class MentorHome extends StatefulWidget {
  @override
  _MentorHomeState createState() => _MentorHomeState();
}

class _MentorHomeState extends State<MentorHome> {
  int selectedIndex;
  final List<Map> items = [
    {
      "img": "assets/images/scheduleapp.png",
      "name": "Your Appointments",
    },
    {"img": "assets/images/msg.jpg", "name": "Messages"},
    {"img": "assets/images/user.png", "name": "My Profile"},
    {
      "img": "assets/images/addappointment.png",
      "name": "Set your available slots"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // var menntor=Provider.of<MentorModel>(context,listen: false);
    // print(menntor);
    // print("uuuuuu");
    return Consumer<MentorProvider>(builder: (_, mentorProv, __) {
      print(mentorProv.currMentor.fullname);
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primaryColor,
          /* leading: Icon(
          Icons.menu,
          color: secondaryColor,
        ), */
          title: Text(
            'Home',
            style: TextStyle(
                fontSize: 17,
                color: secondaryColor,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: secondaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Notifications()));
                })
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  mentorProv.isCurrMentorAvailable()
                      ? mentorProv.currMentor.fullname
                      : "Guest",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                accountEmail: Text(mentorProv.isCurrMentorAvailable()
                    ? mentorProv.currMentor.email
                    : "Guest Email"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.android
                          ? secondaryColor
                          : primaryColor,
                  child: Text(
                    getInitials(mentorProv.isCurrMentorAvailable()
                        ? mentorProv.currMentor.fullname
                        : "Guest"),
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Account Settings'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Accountsetting()));
                },
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.file),
                title: Text('Terms & Conditions'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TermsAndConditions()));
                },
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Contact us'),
                onTap: () {},
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.infoCircle,
                ),
                title: Text('About the app'),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Aboutus()));
                },
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.signOutAlt,
                ),
                title: Text('Log out'),
                onTap: () async {
                  await AuthService().signOut(context).then((success) {
                    if (success) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => MentorLogin()),
                          (Route<dynamic> route) => false);
                    }
                  });
                },
              ),
            ],
          ),
        ),
        body: Container(
          color: secondaryColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: 50),
                Container(
                  child: Text(
                    'Welcome, ${mentorProv.currMentor.fullname}',
                    style: TextStyle(
                        fontSize: 22,
                        color: inputTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.width / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  if (index == 0) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MentorScheduledAppointments()));
                                  } else if (index == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ChatsPage()));
                                  } else if (index == 2) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AccountDetails()));
                                  } else if (index == 3) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AvailableSlots()));
                                  }
                                });
                              },
                              child: Card(
                                color: selectedIndex == index
                                    ? primaryColor
                                    : secondaryColor,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: primaryColor),
                                    borderRadius: BorderRadius.circular(10)),
                                /*   decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.teal[200],
                                  Colors.teal,
                                ],
                              ),
                             ), */
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Image.asset(
                                        items[index]['img'],
                                        fit: BoxFit.cover,
                                      ),
                                      height: 50,
                                      width: 50,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      items[index]['name'],
                                      maxLines: 2,
                                      style: TextStyle(
                                        height: 1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: selectedIndex == index
                                            ? secondaryColor
                                            : buttonTextColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                //
              ],
            ),
          ),
        ),
      );
    });
  }
}
