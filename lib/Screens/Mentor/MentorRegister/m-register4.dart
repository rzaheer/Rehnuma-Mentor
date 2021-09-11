import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rehnuma_mentor/CustomWidgets/Custombutton.dart';
import 'package:rehnuma_mentor/CustomWidgets/Customtoast.dart';
import 'package:rehnuma_mentor/Screens/Mentor/MentorRegister/m-register3.dart';
import 'package:rehnuma_mentor/Screens/Mentor/mlogin/mlogin.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';

import '../../../Global.dart';

class MentorRegister4 extends StatefulWidget {
  final MentorModel mentorModel;
  MentorRegister4({this.mentorModel});

  @override
  _MentorRegister4State createState() => _MentorRegister4State();
}

class _MentorRegister4State extends State<MentorRegister4> {
  int selectedIndex;
  TextEditingController jobDescController = TextEditingController();
  TextEditingController expController = TextEditingController();
  String education = 'Level Of Education';
  // To store dropdown value in the DB as text
  String field = 'Field Of Education';
  // To store dropdown value in the DB as text
  List<String> levels = ["BS", "MSc", "PhD"];
  List<String> fields = [
    "Behavioral Sciences",
    "Social Sciences",
    "Human Development"
        "Psychology",
    "Clinical psychology",
    "Counseling Psychology",
    "Cognitive Psychology",
    "Occupational psychology",
  ];

  MentorModel currMentorModel = MentorModel();
  final _formKey = GlobalKey<FormState>();
  String email = "";

  int expYear;
  @override
  void initState() {
    super.initState();
    currMentorModel = widget.mentorModel;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(30),
            width: size.width,
            height: size.height,
            color: primaryColor,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    'Customize your Profile',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      color: textColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: DropdownButtonFormField(
                      hint: Text(
                        'Level Of Education',
                        style: TextStyle(color: secondaryColor),
                      ),
                      items: levels.map((String value) {
                        return new DropdownMenuItem(
                            value: value,
                            child: Row(
                              children: <Widget>[
                                Text(value),
                              ],
                            ));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() => education = newValue);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        filled: true,
                        fillColor: Colors.white30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: DropdownButtonFormField(
                      hint: Text(
                        'Field Of Education',
                        style: TextStyle(color: secondaryColor),
                      ),
                      items: fields.map((String field) {
                        return new DropdownMenuItem(
                            value: field,
                            child: Row(
                              children: <Widget>[
                                Text(field),
                              ],
                            ));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() => field = newValue);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        filled: true,
                        fillColor: Colors.white30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /*  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.9,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 4,
                        ),
                        itemCount: tags.length,
                        itemBuilder: (BuildContext context, int i) {
                          return SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  setState(() {
                                    selectedIndex = i;
                                  });
                                });
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => PaymentWebView()));

                                //                     Navigator.push(
                                // context,
                                // MaterialPageRoute(
                                //     builder: (context) => TestWebview()));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: selectedIndex == i
                                    ? inputTextColor
                                    : Colors.white54,
                                elevation: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      tags[i],
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Text(
                    'Other? Add here',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: size.width / 1.7,
                    child: TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          color: secondaryColor,
                        ),
                        focusColor: secondaryColor,
                        fillColor: Colors.white30,
                        filled: true,
                      ),
                    ),
                  ), */
                  Center(
                    child: TextFormField(
                        controller: jobDescController,
                        decoration: InputDecoration(
                          hintText: 'Job Title',
                          hintStyle: TextStyle(
                            color: secondaryColor,
                          ),
                          focusColor: secondaryColor,
                          fillColor: Colors.white30,
                          filled: true,
                        ),
                        validator: (v) {
                          if (v.isEmpty) {
                            return "Please Enter a short job description/title";
                          } else
                            return null;
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: TextFormField(
                        controller: expController,
                        decoration: InputDecoration(
                          hintText: 'Years of Experience',
                          hintStyle: TextStyle(
                            color: secondaryColor,
                          ),
                          focusColor: secondaryColor,
                          fillColor: Colors.white30,
                          filled: true,
                        ),
                        validator: (v) {
                          if (v.isEmpty) {
                            return "Please Enter Your years of Experience";
                          } else
                            return null;
                        }),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: CustomButton(
                      buttoncolor: buttonColor,
                      height: 50,
                      width: size.width / 2,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (education != null && field != null) {
                            print("hogya");
                            print(education);
                            print(field);
                            print(MentorModel);
                            MentorModel _mentorModel = MentorModel(
                              fullname: currMentorModel.fullname,
                              jobDesc: jobDescController.text,
                              expYears: expController.text,
                              gender: currMentorModel.gender,
                              educationlevel: education,
                              fieldOfEducation: field,
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MentorRegister3(
                                          mentorModel: _mentorModel,
                                        )));
                          } else {
                            CustomToast()
                                .showerrorToast("Please fill all fields");
                          }
                          /* AuthService().registerWithEmailAndPassword(
                                StudentModel(), context); */
                        }
                      },
                      title: 'DONE',
                    ),
                  )
                ])),
      ),
    );
  }
}
