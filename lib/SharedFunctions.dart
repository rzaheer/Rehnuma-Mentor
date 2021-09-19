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