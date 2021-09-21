import 'package:flutter/material.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';
import 'package:flutter/cupertino.dart';

class MentorProvider extends ChangeNotifier {
  MentorModel currMentor;

  setCurrentMentor(MentorModel mentorModel) {
    currMentor = mentorModel;
    print("Current mentor has been set to ${currMentor.email} in provider");
    notifyListeners();
  }

  bool isCurrMentorAvailable() {
    if (currMentor != null)
      return true;
    else
      return false;
  }

  clearMentorInProvider() {
    currMentor = null;
    
  }
}
