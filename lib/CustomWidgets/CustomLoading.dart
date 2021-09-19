
import 'package:flutter/material.dart';
import 'package:rehnuma_mentor/Global.dart';
import 'package:rehnuma_mentor/SharedFunctions.dart';

class CustomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeWidth(context),
      height: sizeHeight(context),
      color: Colors.black45,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 5,
          valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}