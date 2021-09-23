
import 'package:flutter/material.dart';
import 'package:rehnuma_mentor/Global.dart';

class NoAppointmentsFound extends StatelessWidget {
  //const NoAppointmentsFound({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height / 2,
            width: size.width / 1.3,
            child: Image.asset(
              'assets/images/appointment.png',
              fit: BoxFit.contain,
            ),
          ),
          Text(
            'No Appointments found!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: inputTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
