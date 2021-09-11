import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rehnuma_mentor/CustomWidgets/Custombutton.dart';
import 'package:rehnuma_mentor/CustomWidgets/Customtoast.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';
import 'package:rehnuma_mentor/services/auth.dart';

import '../../../Global.dart';
import 'm-register2.dart';

class MentorRegister1 extends StatefulWidget {
  @override
  _MentorRegister1State createState() => _MentorRegister1State();
}

class _MentorRegister1State extends State<MentorRegister1> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController cnicController = TextEditingController();

  final format = DateFormat("dd-MM-yyyy");
  DateTime selectedDate = DateTime.now();
  bool maleSelected = true, femaleSelected = false, otherSelected = false;
  String selectedGender = " ";
  final _formKey = GlobalKey<FormState>();

  void _handleRadioValueChange(String value) {
    setState(() {
      selectedGender = value;
    });
    print(selectedGender);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                        'Lets Start with the \nbasics',
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
                            controller: fnameController,
                            autocorrect: true,
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                              hintStyle: TextStyle(
                                color: secondaryColor,
                              ),
                              focusColor: secondaryColor,
                              fillColor: Colors.white30,
                              filled: true,
                            ),
                            validator: (v) {
                              if (v.isEmpty) {
                                return "Required";
                              } else
                                return null;
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio(
                            groupValue: selectedGender,
                            onChanged: _handleRadioValueChange,
                            value: "Male",
                          ),
                          Text(
                            'Male',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: textColor,
                            ),
                          ),
                          Radio(
                            groupValue: selectedGender,
                            onChanged: _handleRadioValueChange,
                            value: "Female",
                          ),
                          Text(
                            'Female',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: textColor,
                            ),
                          ),
                          Radio(
                              groupValue: selectedGender,
                              onChanged: _handleRadioValueChange,
                              value: "Other"),
                          Text(
                            'Other',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SizedBox(
                        width: size.width / 1.2,
                        child: TextFormField(
                            controller: cnicController,
                            keyboardType: TextInputType.number,
                            maxLength: 13,
                            decoration: InputDecoration(
                              hintText: 'CNIC Number',
                              hintStyle: TextStyle(
                                color: secondaryColor,
                              ),
                              focusColor: secondaryColor,
                              fillColor: Colors.white30,
                              filled: true,
                            ),
                            validator: (v) {
                              if (v.isEmpty && v.length < 13) {
                                return "Required";
                              } else
                                return null;
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: CustomButton(
                        height: 50,
                        buttoncolor: buttonColor,
                        width: size.width / 2,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            if (selectedGender != null) {
                              print("Validate hogaya");
                              MentorModel _mentorModel = MentorModel(
                                fullname: fnameController.text,
                                gender: selectedGender,
                                cnic: cnicController.text,
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MentorRegister2(
                                            mentorModel: _mentorModel,
                                          )));
                            } else {
                              CustomToast()
                                  .showerrorToast("Please fill all fields");
                            }
                            /*   AuthService().signInEmailPass(
                                MentorModel(), context); */
                          }
                        },
                        title: 'NEXT',
                      ),
                    )
                  ]),
            )),
      ),
    );
  }
}
