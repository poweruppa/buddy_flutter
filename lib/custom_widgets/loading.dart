import 'package:buddy_flutter/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitRing(
          color: Colors.blueGrey,
          size: displayHeight(context) * 0.08,
        ),
      ),
    );
  }
}
