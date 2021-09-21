import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rehnuma_mentor/CustomWidgets/Custombutton.dart';
import 'package:rehnuma_mentor/Screens/Mentor/MentorRegister/m-register4.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';

import '../../../Global.dart';
import 'm-register3.dart';

class MentorRegister2 extends StatefulWidget {
  final MentorModel mentorModel;
  MentorRegister2({this.mentorModel});

  @override
  _MentorRegister2State createState() => _MentorRegister2State();
}

class _MentorRegister2State extends State<MentorRegister2> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  MentorModel currMentorModel = MentorModel();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  @override
  void initState() {
    super.initState();
    currMentorModel = widget.mentorModel;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool isValid = EmailValidator.validate(email);

    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(10),
          width: size.width,
          height: size.height,
          color: primaryColor,
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      'How can we contact  \nyou?',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: textColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: SizedBox(
                      width: size.width / 1.2,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: secondaryColor,
                          ),
                          focusColor: secondaryColor,
                          fillColor: Colors.white30,
                          filled: true,
                        ),
                        validator: (val) => val.isEmpty || isValid == false
                            ? 'Please provide valid Email'
                            : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: size.width / 1.2,
                      child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                            color: secondaryColor,
                          ),
                          focusColor: secondaryColor,
                          fillColor: Colors.white30,
                          filled: true,
                        ),
                        validator: (v) {
                          if (v.isEmpty && v.length < 11) {
                            return "Required";
                          } else
                            return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: CustomButton(
                      buttoncolor: buttonColor,
                      height: 50,
                      width: size.width / 2,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          MentorModel _mentorModel = currMentorModel;
                          _mentorModel.phone = phoneController.text;
                          _mentorModel.email = emailController.text;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MentorRegister4(
                                        mentorModel: _mentorModel,
                                      )));
                        } else
                          print("nikal be");
                      },
                      title: 'NEXT',
                    ),
                  )
                ]),
          )),
    );
  }
}
