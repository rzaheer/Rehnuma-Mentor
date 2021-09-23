import 'package:rehnuma_mentor/Global.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rehnuma_mentor/Screens/Mentor/MentorHome/Mentorscheduledapp.dart/appointmentDetails.dart';
import 'package:rehnuma_mentor/models/appointmentModel.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key key,
    @required this.docname,
    @required this.dateDay,
    @required this.time,
    @required this.appModel
  }) : super(key: key);
  final String docname;
  final String dateDay;
  final String time;
  final AppointmentModel appModel;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border(
          bottom: BorderSide(color: inputTextColor, width: 1),
          left: BorderSide(
            color: inputTextColor,
            width: 1,
          ),
          right: BorderSide(
            color: inputTextColor,
            width: 1,
          ),
          top: BorderSide(
            color: inputTextColor,
            width: 1,
          ),
        ),
      ),
      height: size.height / 4.5,
      width: size.width / 1.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'Appointment with ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                docname,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              FaIcon(
                FontAwesomeIcons.calendarAlt,
                color: Colors.green,
                size: 22,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "starting Time: $dateDay",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              FaIcon(
                FontAwesomeIcons.userClock,
                color: Colors.red[700],
                size: 22,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "ending Time: $time",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  width: 10,
                ),
              ),
              SizedBox(
                height: 40,
                width: size.width / 2.5,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  splashColor: Colors.white,
                  highlightColor: buttonColor,
                  disabledColor: buttonTextColor,
                  focusColor: buttonColor,
                  elevation: 6,
                  color: primaryColor,
                  // padding: const EdgeInsets.all(8.0),
                  onPressed: () 
                   {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentDetails(appointment: appModel,)));
                  },
                  child: Text(
                    'View details',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
