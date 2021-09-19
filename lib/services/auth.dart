import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:rehnuma_mentor/CustomWidgets/Customtoast.dart';
import 'package:rehnuma_mentor/models/mentorModel.dart';
import 'package:rehnuma_mentor/models/user.dart';
import 'package:rehnuma_mentor/services/DBservice.dart';
import 'package:rehnuma_mentor/services/Providers/MentorProvider.dart';

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignin = new GoogleSignIn();
  final fireStore = FirebaseFirestore.instance;
  final CollectionReference students =
      FirebaseFirestore.instance.collection("Mentors");
 

  User get getUser => _auth.currentUser;
  Future<bool> signInEmailPass(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {});
      if (result.user != null) {
        return await DBService().getMentorByUid(result.user.uid).then((mentor) {
          Provider.of<MentorProvider>(context, listen: false)
              .setCurrentMentor(mentor);
          CustomToast().showsuccessToast("Login successful");
          return true;
        });
      } else
        return false;
    } on FirebaseAuthException catch (error) {
      print("firebase aUTH eXCePTION ayaaaa hai");
      if (error.code == 'user-not-found') {
        CustomToast().showerrorToast('User not found');
      } else if (error.code == 'wrong-password') {
        CustomToast().showerrorToast('Invalid password');
      } else if (error.code == 'network-request-failed') {
        CustomToast().showerrorToast('Network error occured');
      } else if (error.code == 'invalid-email') {
        CustomToast().showerrorToast('Invalid Email');
      } else {
        CustomToast().showerrorToast('Oops, an error has occured');
      }
      print(error.toString());

      return false;
    } on PlatformException catch (error) {
      print("Platform Exception");
      CustomToast().showerrorToast('Oops, an error has occured');
      print(error.toString());
      return false;
    }
  }

  /* Future registerWithEmailAndPassword(
      mentorModel menModel, BuildContext context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: menModel.email, password: studentModel.password);
      // StudentModel studentModel = StudentModel(
      //     studentId: result.user.uid,
      //     dob: "3-07-1999",
      //     email: "ammar555@gmail.com",
      //     firstname: "Ammar555",
      //     gender: 0,
      //     lastname: "Z",
      //     password: "ammar123",
      //     phone: "000");
      if (result.user != null) {
        User firebaseUser = result.user;

        await students
            .doc(result.user.uid)
            .set(studentModel.toJson())
            .whenComplete(() {
          // Provider.of<UserDetailProvider>(context, listen: false)
          //     .setUserDetail(userDetail);
        });

        print("new user created hurray");
        return true;
      } else {
        return null;
      }
    } catch (error) {
      print(error.message);
      return null;
    }
  } */
  Future<bool> registerWithEmailAndPassword(
      MentorModel mentorModel, BuildContext context) async {
    print("Registering....");
    print("Password " + mentorModel.password);
    print("Email " + mentorModel.email);
    print("Phone " + mentorModel.phone);
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: mentorModel.email, password: mentorModel.password);
      MentorModel mentorrModel = MentorModel(
        mentorId: result.user.uid,
        email: mentorModel.email,
        fullname: mentorModel.fullname,
        cnic: mentorModel.cnic,
        expYears: mentorModel.expYears,
        fieldOfEducation: mentorModel.fieldOfEducation,
        jobDesc: mentorModel.jobDesc,
        password: mentorModel.password,
        phone: mentorModel.password,
        educationlevel: mentorModel.educationlevel,
        gender: mentorModel.gender,
      );
      if (result.user != null) {
        /*  User firebaseUser = result.user; */

        return await students
            .doc(result.user.uid)
            .set(mentorrModel.toJson())
            .then((value) {
          Provider.of<MentorProvider>(context, listen: false)
              .setCurrentMentor(mentorModel);
          return true;
        });
      } else {
        print('fail hugya registration bachu');
        return null;
      }
    } catch (error) {
      print(error.message);
      return null;
    }
  }

  /// README: sign out
  Future<bool> signOut(BuildContext context) async {
    try {
      return await _auth.signOut().then((value) {
        Provider.of<MentorProvider>(context, listen: false)
            .clearMentorInProvider();
        return true;
      }).whenComplete(() {});
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  /* setProvider(user, BuildContext context) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection("Users");
    var u = await users.doc(user.uid).get();
    UserDetModel userDetModel = UserDetModel(
        userID: u.data()["userUid"],
        firstName: u.data()["firstName"],
        lastName: u.data()["lastName"],
        email: u.data()["email"]);
    print(u.data()["firstName"]);
    print(userDetModel.firstName);
    await Provider.of<UserDetailProvider>(context, listen: false)
        .setUserDetail(userDetModel);
  } */

  Future passwordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      CustomToast().showsuccessToast('Reset link sent');
    } catch (e) {
      CustomToast().showerrorToast('Oops! An error has occured');
      return null;
    }
  }

//Google Sign in
  Future gsignIn(MentorModel mentortModel, BuildContext context) async {
    GoogleSignInAccount googleSignInAccount = await googleSignin.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    if (authResult.user != null) {
      User firebaseUser = authResult.user;
      print(firebaseUser.email);

      print("User Name:${user.email}");
      return true;
    } else {
      print('Sign in failed');
    }
  }

  //googleSignout
  Future gsignOut() async {
    GoogleSignIn().signOut().whenComplete(() {
      print('Signed out succesfully');
    });
    return await _auth.signOut();
  }
}
