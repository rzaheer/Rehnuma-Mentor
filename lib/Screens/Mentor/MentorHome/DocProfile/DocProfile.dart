import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rehnuma_mentor/services/Providers/MentorProvider.dart';

import '../../../../Global.dart';

class AccountDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  File _image;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 90,
      maxWidth: 90,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(
                        Icons.photo_camera,
                        color: Colors.blue,
                        size: 25,
                      ),
                      title: new Text(
                        'Camera',
                        style: TextStyle(
                            color: inputTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      onTap: () {
                        getImageFromCamera();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_library,
                      color: buttonColor,
                      size: 25,
                    ),
                    title: new Text(
                      'Gallery',
                      style: TextStyle(
                          color: inputTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    onTap: () {
                      getImageFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: primaryColor,
            ),
          ),
          elevation: 0,
          backgroundColor: secondaryColor,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Consumer<MentorProvider>(builder: (_, studentProv, __) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                            child: CircleAvatar(
                                backgroundColor: primaryColor,
                                radius: 55,
                                child: _image == null
                                    ? Icon(
                                        Icons.account_circle,
                                        color: Colors.white38,
                                        size: 110,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.file(
                                          _image,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ))),
                        Positioned(
                          left: 65,
                          bottom: 0,
                          child: CircleAvatar(
                            backgroundColor: buttonColor,
                            radius: 20,
                            child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.camera,
                                color: secondaryColor,
                                size: 17,
                              ),
                              onPressed: () {
                                _showPicker(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ACCOUNT INFORMATION',
                            style: TextStyle(
                              fontSize: 17,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            )),
                        /*   Icon(
                          Icons.edit,
                          size: 20,
                          color: buttonColor,
                        ), */
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Username: ',
                      style: TextStyle(
                        fontSize: 15,
                        color: inputTextColor,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(studentProv.currMentor.fullname,
                      style: TextStyle(
                        fontSize: 15,
                        color: inputTextColor,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Email: ',
                      style: TextStyle(
                        fontSize: 15,
                        color: inputTextColor,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(studentProv.currMentor.email,
                      style: TextStyle(
                        fontSize: 17,
                        color: inputTextColor,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Phone: ',
                      style: TextStyle(
                        fontSize: 15,
                        color: inputTextColor,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(studentProv.currMentor.phone,
                      style: TextStyle(
                        fontSize: 17,
                        color: inputTextColor,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text('CNIC: ',
                      style: TextStyle(
                        fontSize: 15,
                        color: inputTextColor,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(studentProv.currMentor.cnic,
                      style: TextStyle(
                        fontSize: 17,
                        color: inputTextColor,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('CAREER INFORMATION',
                            style: TextStyle(
                              fontSize: 17,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            )),
                        /*     Icon(
                          Icons.edit,
                          size: 20,
                          color: buttonColor,
                        ), */
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Job Description',
                      style: TextStyle(
                        fontSize: 15,
                        color: inputTextColor,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(studentProv.currMentor.jobDesc,
                      style: TextStyle(
                        fontSize: 17,
                        color: inputTextColor,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Years Of Experience: ',
                      style: TextStyle(
                        fontSize: 15,
                        color: inputTextColor,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(studentProv.currMentor.expYears,
                      style: TextStyle(
                        fontSize: 17,
                        color: inputTextColor,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              );
            })));
  }
}
