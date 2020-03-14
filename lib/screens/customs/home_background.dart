import 'dart:math';
import 'package:flutter/material.dart';
import 'custom_clipper.dart';
import 'home_custom_clipper.dart';

class HomeBackground extends StatefulWidget {
  @override
  _HomeBackgroundState createState() => _HomeBackgroundState();
}

class _HomeBackgroundState extends State<HomeBackground> {
  var SecondColor = Colors.amber[500];

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: CustomShapeClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [SecondColor, SecondColor],
                    ),
                  ),
                  height: 260,
                ),
              ),
              Container(),
            ],
          ),
          //
          Spacer(),
          Stack(
            children: <Widget>[
              Transform.rotate(
                child: Container(
                  child: ClipPath(
                    clipper: CustomHomeShapeClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [SecondColor, SecondColor],
                        ),
                      ),
                      height: 160,
                    ),
                  ),
                ),
                angle: pi,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
