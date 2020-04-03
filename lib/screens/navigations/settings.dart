import 'package:flutter/material.dart';
import 'package:phone_auth_app/screens/home/edit_post.dart';
import 'package:phone_auth_app/screens/home/intro.dart';
import 'package:phone_auth_app/services/auth.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();

  var settingsText = Row(
    children: <Widget>[
      Text(
        "Settings",
        textScaleFactor: 1.5,
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(
        children: <Widget>[
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: settingsText,
          ),
          Divider(
            thickness: 2,
          ),
          buildLogOutListTile(),
          Divider(),
          buildEditProfileListTile(context),
          Divider(),
        ],
      )),
    );
  }

  ListTile buildEditProfileListTile(BuildContext context) {
    return ListTile(
          title: Row(
            children: <Widget>[
              Icon(Icons.edit),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPost()));
          },
        );
  }

  ListTile buildLogOutListTile() {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(Icons.settings_power),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      onTap: () async {
        await _auth.signOut().then((response){
          print(response.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Intro()));

        });
        
      },
    );
  }
}
