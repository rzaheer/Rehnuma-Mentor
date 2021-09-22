
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehnuma_mentor/Global.dart';
import 'package:rehnuma_mentor/Screens/chatScreens/chat_body_widget.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';
import 'package:rehnuma_mentor/models/msgModels.dart';
import 'package:rehnuma_mentor/services/Providers/MentorProvider.dart';
import 'package:rehnuma_mentor/services/firebase_api.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    
    // print("uuuuuu");
    return Consumer<MentorProvider>(builder: (_, mentorProv, __){
      print(mentorProv.currMentor.fullname);
      return Scaffold(
      appBar: AppBar(title:Text("All Chats")),
          backgroundColor: primaryColor,
          body: SafeArea(
            child: StreamBuilder<List<AllMsgModel>>(
              stream: FirebaseApi.getAllMessages(mentorProv.currMentor.mentorId),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return buildText('Something Went Wrong Try later');
                    } else {
                      final users = snapshot.data;

                      if (users.isEmpty) {
                        return buildText('No Users Found');
                      } else
                        return Column(
                          children: [
                            //ChatHeaderWidget(mentor: users),
                            ChatBodyWidget(studentList: users)
                          ],
                        );
                    }
                }
              },
            ),
          ),
        );
    });
}
  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}