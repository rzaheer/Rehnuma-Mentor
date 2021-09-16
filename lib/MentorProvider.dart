import 'package:flutter/cupertino.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';

class MentorProvider extends ChangeNotifier {
  MentorModel currMentor;

  setCurrentMentor(MentorModel mentorModel) {
    currMentor = mentorModel;
    notifyListeners();
  }
}
