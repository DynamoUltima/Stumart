import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_auth_app/screens/customs/custom_clipper.dart';
import 'package:phone_auth_app/screens/home/news_feed.dart';
import 'package:phone_auth_app/screens/home/post_profile.dart';
import 'package:phone_auth_app/services/auth.dart';
import 'package:phone_auth_app/shared/loading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var secondColor = Colors.teal[400];
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String _email;
  String _password;
  bool loading = false;

  Widget _loginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 90),
      child: Hero(
        child: RaisedButton(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
          ),
          onPressed: () async {
            if (_formkey.currentState.validate()) {
              setState(() => loading = true);
              dynamic result = await _auth
                  .reisterWithEmailAndPassword(_email, _password)
                  .catchError((e) {
                if (e) {
                  print("error" + e);
                }
              });

              // print(result.uid);

              if (result == null) {
                print("couldn't logged in");
                setState(() {
                  loading = false;
                });
              } else {
                print(result.uid);
                setState(() {
                  loading = false;
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewsFeedPage(),
                  ),
                ); //NewsFeedPage()//PostProfile()
              }
            }
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
    return loading
        ? Loading()
        : Scaffold(
            body: Stack(
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
                        _buildEmail(),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        buildPassword(),
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

  Padding buildPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        onChanged: (val) {
          setState(() {
            _password = val;
          });
        },
        validator: (val) {
          if (val.isEmpty) {
            return "Enter password";
          }
          return null;
        },
        decoration: InputDecoration(
            isDense: true,
            labelStyle: TextStyle(),
            labelText: 'Password',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)))),
      ),
    );
  }

  Padding _buildEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (val) {
          setState(() {
            _email = val;
          });
        },
        validator: (val) {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(val)) {
            return "Enter Valid Email";
          }
          return null;
        },
        decoration: InputDecoration(
          isDense: true,
          labelText: 'Email Address',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
