import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getInitials(String firstName) {
  return firstName[0].toUpperCase();
//    return firstName.trim()[0].toUpperCase() + lastName.trim()[0].toUpperCase();
}

String getSlotTimeString({DateTime start, DateTime end}) {
  String startTimeString = DateFormat('hh:mm').format(start);

  String endTimeString = DateFormat('hh:mm').format(end);
  String concat = startTimeString + "-" + endTimeString;
  return concat;
}

sizeWidth(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth;
}

sizeHeight(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  return screenHeight;
}

String formatTime24Hr(DateTime dateTime) {
  String formattedTime = DateFormat('HH:mm').format(dateTime);
  return formattedTime;
}

String formatTime12Hr(DateTime dateTime) {
  String formattedTime = DateFormat('hh:mm a').format(dateTime);
  return formattedTime;
}

String formatDate(DateTime dateTime) {
  String formattedTime = DateFormat("yMMMEd").format(dateTime);
  return formattedTime;
}
