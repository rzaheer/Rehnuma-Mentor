import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:rehnuma_mentor/CustomWidgets/Customtoast.dart';
import 'package:rehnuma_mentor/models/AppointmentModel.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';
import 'package:rehnuma_mentor/models/slotModel.dart';
import 'package:rehnuma_mentor/services/Providers/MentorProvider.dart';

class DBService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference mentorCollection =
      FirebaseFirestore.instance.collection('Mentors');
  CollectionReference appointmentCol =
      FirebaseFirestore.instance.collection('Appointments');
  /* Future<List<UniversityModel>> getData(String uni) async {
    List<UniversityModel> _allUnis = [];
    //url for recommender
    String url = baseUrl + "result";

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll({"Content-type": "multipart/form-data"});
    request.fields['uni'] = uni;

    try {
      var res = await request.send();
      var _response = await http.Response.fromStream(res);
      if (_response.statusCode == 200) {
        print("Succesfull");
        var jBody = JsonDecoder().convert(_response.body);
        for (var uni in jBody) {
          UniversityModel model = UniversityModel.fromJson(uni);
          _allUnis.add(model);
        }
        print(jBody);
        return _allUnis;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  } */

  /*  ///get All uni from this api
  Future<List<String>> getAllUni() async {
    List<String> _allUnis = [];
    //url for recommender
    String url = baseUrlAllUni + "getAllUniversities";

    var request = http.MultipartRequest('GET', Uri.parse(url));

    request.headers.addAll({"Content-type": "multipart/form-data"});

    try {
      var res = await request.send();
      var _response = await http.Response.fromStream(res);
      if (_response.statusCode == 200) {
        print("Succesfull");
        var jBody = JsonDecoder().convert(_response.body);
        for (var uni in jBody) {
          _allUnis.add(uni);
        }

        return _allUnis;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  } */

  Future<List<SlotModel>> getSlotsList() async {
    CollectionReference slotRef = _db.collection('Slots');

    List<SlotModel> _allSlots = [];
    try {
      QuerySnapshot qs = await FirebaseFirestore.instance
          .collection("Slots")
          .get()
          .then((value) {
        print(value.docs);
        return value;
      });
      print(qs.docs.length);
      _allSlots = qs.docs
          .map((DocumentSnapshot doc) => SlotModel.fromMap(doc.data()))
          .toList();
      print(_allSlots.length);
      return _allSlots;
    } catch (e) {
      print("Error in mentor get list: " + e.toString());
      return null;
    }
  }

  Future<MentorModel> getMentorByUid(String uid) async {
    try {
      DocumentSnapshot doc = await mentorCollection.doc(uid).get();
      if (doc != null) {
        MentorModel mentor = MentorModel.fromJson(doc.data());

        return mentor;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: " + e.toString());
      return null;
    }
  }

  Future<bool> addSlot(String mentorId, String slotId) async {
    try {
      return await mentorCollection.doc(mentorId).update({
        'slots': FieldValue.arrayUnion([slotId])
      }).then((value) {
        return true;
      });
    } catch (e) {
      CustomToast().showerrorToast(e.toString());
      return false;
    }
  }

  Future<bool> removeSlot(String mentorId, String slotId) async {
    try {
      return await mentorCollection.doc(mentorId).update({
        'slots': FieldValue.arrayRemove([slotId])
      }).then((value) {
        return true;
      });
    } catch (e) {
      CustomToast().showerrorToast(e.toString());
      return false;
    }
  }

  Future<List<AppointmentModel>> getScheduledAppointments(
      String mentorId) async {
    List<AppointmentModel> allAppointments = [];
    try {
      return await appointmentCol
          .where("mentorId", isEqualTo: mentorId)
          .where("isCompleted", isEqualTo: false)
          .where("paymentReceived", isEqualTo: true)
          .get()
          .then((QuerySnapshot qs) {
        if (qs.docs.isNotEmpty) {
          print("object: " + qs.docs.length.toString());
          qs.docs.forEach((app) {
            allAppointments.add(AppointmentModel.fromJson(app.data()));
          });
        }
        return allAppointments;
      });
    } catch (e) {
      print("Error: " + e.toString());
      CustomToast().showerrorToast(e.toString());
      return null;
    }
  }

  Future<List<AppointmentModel>> getPastAppointments(String studentId) async {
    List<AppointmentModel> allAppointments = [];
    try {
      return await appointmentCol
          .where("studentId", isEqualTo: studentId)
          .where("isCompleted", isEqualTo: true)
          .where("paymentReceived", isEqualTo: true)
          .get()
          .then((QuerySnapshot qs) {
        if (qs.docs.isNotEmpty) {
          qs.docs.forEach((app) {
            allAppointments.add(AppointmentModel.fromJson(app.data()));
          });
        }
        return allAppointments;
      });
    } catch (e) {
      print("Error: " + e.toString());
      CustomToast().showerrorToast(e.toString());
      return null;
    }
  }
}
