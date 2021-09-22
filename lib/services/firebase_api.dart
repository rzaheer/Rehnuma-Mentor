import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';
import 'package:rehnuma_mentor/models/msgModels.dart';
import 'package:rehnuma_mentor/models/studentModel.dart';

//import '../utils.dart';
StreamTransformer transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final users = snaps.map((json) => fromJson(json)).toList();

          sink.add(users);
        },
      );

class FirebaseApi {
  static Stream<List<AllMsgModel>> getAllMessages(String mentorId) => FirebaseFirestore.instance
      .collection('messages').where("mentorId",isEqualTo: mentorId)
      //.orderBy("lastMessageTime", descending: true)
      .snapshots()
      .transform(transformer(AllMsgModel.fromJson));

  static Future uploadMessage({StudentModel student,MentorModel mentor, String message}) async {
    final refMessages =
        FirebaseFirestore.instance.collection('messages');
    try{   
      var time=DateTime.now();
      var allMsgField=AllMsgModel(messageId: "${student.studentId}-${mentor.mentorId}",
      mentorId: mentor.mentorId,
       mentorName: mentor.fullname, 
       studentId: student.studentId, 
       lastMessageTime: time,
      studentName: "${student.firstname}"); 
    await refMessages.doc("${student.studentId}-${mentor.mentorId}").set(allMsgField.toJson()).then((value){
    //print(value.documentID);
  });
    final newMessage = Message(
      sentBy: mentor.mentorId,
       message: message,
      createdAt: time,
    );
    await refMessages.doc("${student.studentId}-${mentor.mentorId}").collection("allMessages").add(newMessage.toJson());
    return true;
    }
  catch(e){
    print(e.toString());
    return false;
  } 
    
  }
  //  
  static Stream<List<Message>> getMessages(String messageId) =>
      FirebaseFirestore.instance
          .collection('messages').doc(messageId).collection("allMessages")
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(transformer(Message.fromJson));

  // static Future addRandomUsers(List<User> users) async {
  //   final refUsers = FirebaseFirestore.instance.collection('users');

  //   final allUsers = await refUsers.get();
  //   if (allUsers.size != 0) {
  //     return;
  //   } else {
  //     for (final user in users) {
  //       final userDoc = refUsers.doc();
  //       final newUser = user.copyWith(idUser: userDoc.id);

  //       await userDoc.set(newUser.toJson());
  //     }
  //   }
  // }
}