import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:rehnuma_mentor/CustomWidgets/Customtoast.dart';
import 'package:rehnuma_mentor/Screens/Mentor/MentorHome/mentorhome.dart';
import 'package:rehnuma_mentor/Screens/Mentor/MentorRegister/m-register1.dart';
import 'package:rehnuma_mentor/services/auth.dart';

import '../../../Global.dart';

class MentorLogin extends StatefulWidget {
  @override
  _MentorLoginState createState() => _MentorLoginState();
}

class _MentorLoginState extends State<MentorLogin> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool isValid = EmailValidator.validate(email);
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            width: size.width,
            height: size.height,
            color: primaryColor,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'LOGIN TO YOUR ACCOUNT',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 40),
                  Text('Email',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),

                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        fontSize: 16,
                        color: inputTextColor,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        filled: true,
                        fillColor: secondaryColor,
                        hintText: 'username@yahoo.com',
                        hintStyle: TextStyle(color: Colors.grey[500])),
                    validator: (val) => val.isEmpty || isValid == false
                        ? 'Please provide valid Email'
                        : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),

                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(right: 220),
                    child: Text('Password',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  TextFormField(
                    obscureText: true,
                    style: TextStyle(
                        fontSize: 16,
                        color: inputTextColor,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        filled: true,
                        fillColor: secondaryColor,
                        hintText: '*********',
                        hintStyle: TextStyle(color: Colors.grey[500])),
                    validator: (val) => val.length < 6
                        ? 'Enter atleast 6 characters long password'
                        : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),

                  SizedBox(height: 40),
                  Center(
                    child: SizedBox(
                        height: 40,
                        width: size.width / 3,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: buttonColor,
                          onPressed: () async {
                            print(email);
                            print(password);
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              bool result = await _auth.signInEmailPass(
                                  email, password, context);
                              if (result == true) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MentorHome()));
                              }
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ),
                  //SizedBox(height: 8),
                  Center(
                    child: FlatButton(
                        onPressed: null,
                        /* onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword1()));
                        }, */
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                  Divider(
                    color: secondaryColor,
                    endIndent: 2,
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      height: 40,
                      width: size.width / 2,
                      child: RaisedButton(
                        elevation: 8,
                        color: Color(0xFF045D4E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text('Signup with ',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                'assets/images/google.png',
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /*  Center(
                    child: SizedBox(
                      height: 40,
                      width: size.width / 2,
                      child: RaisedButton(
                        elevation: 8,
                        color: Color(0xFF324272),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentHome()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text('Signup with ',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                'assets/images/facebook.png',
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ), */
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MentorRegister1()));
                        },
                        child: Text.rich(
                          TextSpan(
                            text: 'New to Rehnuma? ',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 15,
                              //fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Signup now',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  )),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
