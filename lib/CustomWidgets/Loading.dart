import 'package:flutter/material.dart';

import '../Global.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size(context).height,
      width: size(context).width,
      color: Colors.black54,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 6,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.indigoAccent),
            backgroundColor: Colors.white60,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Please wait...',
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}
