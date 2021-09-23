import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehnuma_mentor/CustomWidgets/Appointmentcard.dart';
import 'package:rehnuma_mentor/Screens/Mentor/MentorHome/Mentorscheduledapp.dart/noAppointmentFound.dart';
import 'package:rehnuma_mentor/models/appointmentModel.dart';
import 'package:rehnuma_mentor/services/Providers/MentorProvider.dart';
import 'package:rehnuma_mentor/services/firebase_api.dart';

import '../../../../Global.dart';

class MentorPastAppointments extends StatefulWidget {
  @override
  _MentorPastAppointmentsState createState() => _MentorPastAppointmentsState();
}

class _MentorPastAppointmentsState extends State<MentorPastAppointments> {
  List<AppointmentModel> appointments = [];
  Future getPastAppointments(String mentorId) async {
    await FirebaseApi().getPastAppointments(mentorId)
       // getActiveAppointments(studentProvider.currStudent.studentId)
        .then((value) {
      if (value != null) {
        print(value);
        setState(() {
          appointments.addAll(value);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var menProvider = Provider.of<MentorProvider>(context, listen: false);
    getPastAppointments(menProvider.currMentor.mentorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        /* leading: Icon(
          Icons.menu,
          color: secondaryColor,
        ), */
        title: Text(
          'Past Appointments',
          style: TextStyle(
              fontSize: 17, color: secondaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          color: secondaryColor,
          child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCard(
                    docname: 'Ms. Kinza',
                    dateDay: '12th Jan 2020',
                    time: '11:00 AM'),
                SizedBox(
                  height: 10,
                ),
                CustomCard(
                    docname: 'Ms. Ramsha',
                    dateDay: '13th Jan 2020',
                    time: '11:00 AM'),
                SizedBox(
                  height: 10,
                ),
              ]),

        ),
      ),
    );

  }
}
