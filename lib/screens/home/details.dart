import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:phone_auth_app/models/user.dart';
import 'package:phone_auth_app/models/user_data.dart';
import 'package:phone_auth_app/models/user_profile.dart';
import 'package:phone_auth_app/screens/home/news_feed.dart';
import 'package:phone_auth_app/services/database.dart';
import 'package:phone_auth_app/shared/loading.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final UserProfile profile;

  DetailsPage({this.profile});
  // : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  UserData userData;
  var personalInfoText = Row(
    children: <Widget>[
      Text(
        "Personal Info",
        textScaleFactor: 1.5,
      ),
    ],
  );

  var otherDetailsText = Row(
    children: <Widget>[
      Text(
        "Other Details",
        textScaleFactor: 1.5,
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).retrieveUserInfo,
        builder: (context, snapshot) {
          userData = snapshot.data;
          

          if (snapshot.hasData) {
            print(userData.first);
            return Scaffold(
              appBar: AppBar(
                title: Text("Details"),
              ),
              body: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: personalInfoText,
                    ),
                    buildPersonalInfo(),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: otherDetailsText,
                    ),
                    buildOtherInfo(),
                    SizedBox(
                      height: 20,
                    ),
                    buildInterestCard(),
                    SizedBox(
                      height: 20,
                    ),
                    buildAddButton(context,userData)
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Widget buildAddButton(BuildContext context, UserData userData) {
    return RaisedButton(
      color: Colors.teal,
      onPressed: () async {
        final user = Provider.of<User>(context, listen: false);
        String notifyMessage =
            "${userData.first} ${userData.last} has sent a request for an internship";
        var notifyTimeStamp = DateTime.now().toUtc().millisecondsSinceEpoch;
        Map<String, Object> notify = HashMap();
        notify.putIfAbsent("notifyMessage", () => notifyMessage);
        notify.putIfAbsent("timestamp", () => notifyTimeStamp.toString());
        //retrieving data
        //DateTime.fromMillisecondsSinceEpoch(doc.data['timestamp'], isUtc: true),
        await DatabaseService(uid: user.uid)
            .notifyUser(notify, widget.profile.postId)
            .then((response) {
          print(response);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewsFeedPage()));
        }).catchError((onError) {
          print(onError);
        });
      },
      child: Text(
        "Add",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget buildInterestCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Container(
            child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.star, color: Colors.teal),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Interest",
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                  textScaleFactor: 1.1,
                ),
              ],
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    widget.profile.interest ?? 'default value',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget buildOtherInfo() {
    return Padding(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.grey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.school, color: Colors.white),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.profile.identity ?? 'default value',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.school, color: Colors.white),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.profile.campus ?? 'default value',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.book, color: Colors.white),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.profile.program ?? 'default value',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.star, color: Colors.white),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.profile.interest ?? 'default value',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.score, color: Colors.white),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.profile.gpa ?? 'default value',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      padding: EdgeInsets.all(16),
    );
  }

  Widget buildPersonalInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(16),
          color: Colors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.person, color: Colors.white),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.profile.first + " " + widget.profile.last ??
                        'default value',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.email, color: Colors.white),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.profile.email ?? 'default value',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.profile.location ?? 'default value',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.phone, color: Colors.white),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.profile.phone ?? 'default value',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.people, color: Colors.white),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.profile.gender ?? 'default value',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
