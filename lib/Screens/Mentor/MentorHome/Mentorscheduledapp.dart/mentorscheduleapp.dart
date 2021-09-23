import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rehnuma_mentor/CustomWidgets/Appointmentcard.dart';
import 'package:rehnuma_mentor/Screens/Mentor/MentorHome/Mentorscheduledapp.dart/noAppointmentFound.dart';
import 'package:rehnuma_mentor/models/appointmentModel.dart';
import 'package:rehnuma_mentor/services/Providers/MentorProvider.dart';
import 'package:rehnuma_mentor/services/firebase_api.dart';
import 'package:rehnuma_mentor/CustomWidgets/Appointmentcard%20copy.dart';
import 'package:rehnuma_mentor/CustomWidgets/Appointmentcard.dart';
import 'package:rehnuma_mentor/models/AppointmentModel.dart';
import 'package:rehnuma_mentor/services/DBservice.dart';
import 'package:rehnuma_mentor/services/Providers/MentorProvider.dart';


import '../../../../Global.dart';
import 'noappointments.dart';

class MentorScheduledAppointments extends StatefulWidget {
  @override
  _MentorScheduledAppointmentsState createState() =>
      _MentorScheduledAppointmentsState();
}

class _MentorScheduledAppointmentsState
    extends State<MentorScheduledAppointments> {

      List<AppointmentModel> appointments = [];
  Future getPastAppointments(String mentorId) async {
    await FirebaseApi().getActiveAppointments(mentorId)
       // getActiveAppointments(studentProvider.currStudent.studentId)

  MentorProvider mentorProvider;
  DBService _db = DBService();
  List<AppointmentModel> appointments = [];

  Future getScheduledAppointments() async {
    await _db
        .getScheduledAppointments(mentorProvider.currMentor.mentorId)

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

    mentorProvider = Provider.of<MentorProvider>(context, listen: false);
    getScheduledAppointments();

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
          'Scheduled Appointments',
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
              appointments.length == 0
                  ? NoAppointmentsFound()
                  : ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: appointments.length,
                      itemBuilder: (_, i) {
                        return AppointmentCard(
                          appointmentModel: appointments[i],
                        );
                      })

            ],
          ),
        ),
      ),
    );
  }
}
