import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_auth_app/screens/authenticate/signup.dart';
import 'package:phone_auth_app/screens/customs/custom_clipper.dart';
import 'package:phone_auth_app/screens/home/news_feed.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  var SecondColor = Colors.teal[400];

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
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
          height: ScreenHeight,
          alignment: Alignment.center,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: ScreenHeight * 0.2,
              ),
              Container(child: image),
              Text('Stumart', style: TextStyle(fontSize: 32, color: Colors.teal[400])),
              SizedBox(
                height: ScreenHeight * 0.1,
              ),
              SizedBox(
                width: ScreenWidth * 0.7,
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
                              builder: (BuildContext context) => NewsFeedPage()));
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
                height: ScreenHeight * 0.05,
              ),
              SizedBox(
                width: ScreenWidth * 0.6,
                child: OutlineButton(
                  onPressed: () {
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
