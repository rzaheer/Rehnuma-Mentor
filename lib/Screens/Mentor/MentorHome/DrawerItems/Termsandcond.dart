import 'package:flutter/material.dart';

import '../../../../Global.dart';

class TermsAndConditions extends StatelessWidget {
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
          'Terms and Conditions',
          style: TextStyle(
              fontSize: 17, color: secondaryColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: secondaryColor,
              ),
              onPressed: null)
        ],
      ),
      body: Container(
          color: secondaryColor,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please read terms and conditions carefully, otherwise you will not be able to access the application:\n\n',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text("1: The Platform:",
                      style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    " Rehnuma is an application that binds student and counselor on a single platform to have career counselling.\n",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text("2: Privacy and Security",
                      style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    "  All the data provided by student and counsellor is private and secure.\n",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text("3: Third Party Services and Content:",
                      style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    " Rehnuma does not endorse third party services and content and you agree that, in no event, will Rehnuma be responsible or liable for any products or services of such third party providers.\n",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ]),
          )),
    );
  }
}
