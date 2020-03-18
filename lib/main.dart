import 'package:flutter/material.dart';
import 'package:phone_auth_app/models/user.dart';
import 'package:phone_auth_app/screens/wrapper.dart';
import 'package:phone_auth_app/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
         theme: ThemeData(
        primaryColor: Colors.teal,
        accentColor: Colors.white,
      ),
        home: Wrapper(),
      ),
    );
  }
}
