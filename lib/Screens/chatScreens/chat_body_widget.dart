
import 'package:flutter/material.dart';
import 'package:rehnuma_mentor/Screens/chatScreens/chat_page.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';
import 'package:rehnuma_mentor/models/msgModels.dart';
import 'package:rehnuma_mentor/models/studentModel.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<AllMsgModel> studentList;

  const ChatBodyWidget({
    @required this.studentList,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: buildChats(),
        ),
      );

  Widget buildChats() => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final stu = studentList[index];

          return Container(
            height: 75,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(student: StudentModel(
                    studentId: stu.studentId,
                    firstname: stu.studentName
                  ))
                  ,
                ));
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/President_Barack_Obama.jpg/480px-President_Barack_Obama.jpg"),
              ),
              title: Text(stu.studentName),
            ),
          );
        },
        itemCount: studentList.length,
      );
}