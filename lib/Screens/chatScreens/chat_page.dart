
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehnuma_mentor/Screens/chatScreens/messages_widget.dart';
import 'package:rehnuma_mentor/Screens/chatScreens/new_message_widget.dart';
import 'package:rehnuma_mentor/Screens/chatScreens/profile_header_widget.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';
import 'package:rehnuma_mentor/models/studentModel.dart';
import 'package:rehnuma_mentor/services/Providers/MentorProvider.dart';

class ChatPage extends StatefulWidget {
  final StudentModel student;

  const ChatPage({
    @required this.student,
    Key key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    var usser=Provider.of<MentorProvider>(context,listen: false);
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: widget.student.firstname),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: MessagesWidget(idUser: "${widget.student.studentId}-${usser.currMentor.mentorId}"),
                ),
              ),
              new
              NewMessageWidget(mentor: usser.currMentor,studentMod:StudentModel(studentId: widget.student.studentId,
              firstname: widget.student.firstname
              ) ,)
            ],
          ),
        ),
      );
}
}