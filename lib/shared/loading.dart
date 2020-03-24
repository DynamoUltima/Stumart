import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white12,
      child: Center(
          child: SpinKitDualRing(
        color: Colors.teal[400],
        size: 50,
      )),
    );
  }
}
