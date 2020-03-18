import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_auth_app/screens/customs/custom_clipper.dart';
import 'package:phone_auth_app/screens/home/news_feed.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var secondColor = Colors.teal[400];
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _loginButton(BuildContext context){

    return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 90),
                    child: Hero(
                      child: RaisedButton(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        onPressed: ()  async{
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsFeedPage()));
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
                  );

  }
  

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body:  Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Welcome Back',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [secondColor, secondColor],
                ),
              ),
              height: 260,
            ),
          ),
          //TODO: make the orientation unchangeable
          //TODO: use safe area for phones with notches on top

         
          Form(
            key: _formkey,
                      child: Container(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: TextFormField(
                      decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Email Address',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)))),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: TextFormField(
                      decoration: InputDecoration(
                          isDense: true,
                          labelStyle: TextStyle(),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)))),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  _loginButton(context)
                ],
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}