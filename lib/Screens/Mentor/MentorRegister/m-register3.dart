import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rehnuma_mentor/CustomWidgets/Custombutton.dart';
import 'package:rehnuma_mentor/CustomWidgets/Customtoast.dart';
import 'package:rehnuma_mentor/CustomWidgets/Loading.dart';
import 'package:rehnuma_mentor/Screens/Mentor/MentorHome/mentorhome.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';
import 'package:rehnuma_mentor/services/auth.dart';
import 'package:rehnuma_mentor/wrapper.dart';
import '../../../Global.dart';

class MentorRegister3 extends StatefulWidget {
  final MentorModel mentorModel;
  MentorRegister3({this.mentorModel});
  @override
  _MentorRegister3State createState() => _MentorRegister3State();
}

class _MentorRegister3State extends State<MentorRegister3> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  MentorModel currMentorModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currMentorModel = widget.mentorModel;
  }

  String validatePassword(String value) {
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value))
        return 'Enter valid password';
      else
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      'Choose a password for   \nyour account',
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
                      height: 45,
                      width: size.width / 1.2,
                      child: TextFormField(
                        controller: passwordController,
                        style: TextStyle(fontSize: 16, color: inputTextColor),
                        obscureText: true,
                        decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white30,
                          hintText: 'New Password',
                        ),
                        validator: (value) {
                          if (validatePassword(value) != null) {
                            CustomToast().showerrorToast(
                                "Password must contain numbers, upper case and lower case letters and special characters.");
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      height: 45,
                      width: size.width / 1.2,
                      child: TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        style: TextStyle(fontSize: 16, color: inputTextColor),
                        decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white30,
                          hintText: 'Confirm Password',
                        ),
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
                        Loading();
                        if (_formKey.currentState.validate()) {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            MentorModel _mentorModel = currMentorModel;
                            _mentorModel.password = passwordController.text;

                            await AuthService()
                                .registerWithEmailAndPassword(
                                    _mentorModel, context)
                                .then((value) {
                              if (value == true) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Wrapper()),
                                    (Route<dynamic> route) => false);
                              } else {
                                CustomToast()
                                    .showerrorToast("Registration failed");
                              }
                            });
                          } else {
                            CustomToast()
                                .showerrorToast("Passwords donot match");
                          }
                        }
                        ;
                      },
                      title: 'NEXT',
                    ),
                  )
                ])),
      ),
    );
  }
}
