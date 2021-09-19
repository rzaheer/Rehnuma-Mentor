import 'package:flutter/material.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';
import 'package:flutter/cupertino.dart';

class MentorProvider extends ChangeNotifier {
  MentorModel currMentor;

  setCurrentMentor(MentorModel mentorModel) {
    currMentor = mentorModel;
    notifyListeners();
  }
}
