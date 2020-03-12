import 'package:flutter/material.dart';
import 'package:phone_auth_app/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Home"),
        backgroundColor: Colors.blue,
        elevation: 1,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: ()async {
              await _auth.signOut();
            },
            icon: Icon(Icons.person),
            label: Text("Logout"),
          )
        ],
      ),
    );
  }
}
