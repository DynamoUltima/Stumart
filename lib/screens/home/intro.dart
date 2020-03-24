import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_auth_app/screens/authenticate/login.dart';
import 'package:phone_auth_app/screens/authenticate/signup.dart';

import 'package:phone_auth_app/screens/home/news_feed.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  var SecondColor = Colors.teal[400];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    AssetImage assetImage = AssetImage('images/image_01.png');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Image image = Image(
      image: assetImage,
      width: 250,
      height: 250,
    );

    return Scaffold(
          body: Container(
        child: Container(
          height: screenHeight,
          alignment: Alignment.center,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: screenHeight * 0.2,
              ),
              Container(child: image),
              Text('Stumart', style: TextStyle(fontSize: 32, color: Colors.teal[400])),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              SizedBox(
                width: screenWidth * 0.7,
                child: Hero(
                  transitionOnUserGestures: true,
                  child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()));
                    },
                    color: Colors.teal[400],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  tag: 'logger',
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              SizedBox(
                width: screenWidth * 0.6,
                child: OutlineButton(
                  onPressed: () async{
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SignUpPage()));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  child: Text('SIGN UP', style: TextStyle(color: Colors.grey)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
