import 'package:flutter/material.dart';
import 'package:phone_auth_app/models/user.dart';
import 'package:phone_auth_app/models/user_data.dart';
import 'package:phone_auth_app/screens/home/news_feed.dart';
import 'package:phone_auth_app/screens/navigations/settings.dart';
import 'package:phone_auth_app/services/database.dart';
import 'package:phone_auth_app/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:phone_auth_app/shared/constants.dart';

class EditPost extends StatefulWidget {
  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  String _firstName;
  String _lastName;
  String _phoneNumber;
  String _location;
  bool loading = false;
  UserData userData;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildFirstName(UserData userData) {
    return TextFormField(
      initialValue: userData.first,
      textCapitalization: TextCapitalization.words,
      decoration: TextDecoration.copyWith(labelText: "FirstName"),
      keyboardType: TextInputType.text,
      validator: (val) {
        if (val.isEmpty) {
          return "Enter First Name";
        }
        return null;
      },
      onChanged: (val) {
        setState(() {
          _firstName = val;
        });
      },
    );
  }

  Widget _buildLastName(UserData userData) {
    return TextFormField(
      initialValue: userData.last,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: TextDecoration.copyWith(labelText: "Last Name"),
      validator: (val) {
        if (val.isEmpty) {
          return "Enter Last Name";
        }
        return null;
      },
      onChanged: (val) {
        setState(() {
          _lastName = val;
        });
      },
    );
  }

  Widget _buildPhoneNumber(UserData userData) {
    return TextFormField(
      initialValue: userData.phone,
      decoration: TextDecoration.copyWith(labelText: "Phone Number"),
      keyboardType: TextInputType.phone,
      validator: (val) {
        if (val.isEmpty) {
          return "Enter Last Name";
        }
        return null;
      },
      onChanged: (val) {
        setState(() {
          _phoneNumber = val;
        });
      },
    );
  }

  Widget _buildLocation(UserData userData) {
    return TextFormField(
      initialValue: userData.location,
      decoration: TextDecoration.copyWith(labelText: "Location"),
      keyboardType: TextInputType.text,
      validator: (val) {
        if (val.isEmpty) {
          return "Enter Last Name";
        }
        return null;
      },
      onChanged: (val) {
        setState(() {
          _location = val;
        });
      },
    );
  }

  Widget _submitButton(User user, UserData userData) {
    return FlatButton(
      onPressed: () async {
        if (_formkey.currentState.validate()) {
          setState(() => loading = true);

          Map<String, Object> userDataInfo = Map();
          userDataInfo.putIfAbsent("first", () => _firstName ?? userData.first);
          userDataInfo.putIfAbsent("last", () => _lastName ?? userData.last);
          userDataInfo.putIfAbsent(
              "phone", () => _phoneNumber ?? userData.phone);
          userDataInfo.putIfAbsent(
              "location", () => _location ?? userData.location);

          await DatabaseService(uid: user.uid).updateUserInfo(userDataInfo);

          if (user == null) {
            setState(() {
              loading = false;
            });
            print("error signing in");
          } else {
            print(user.uid);
            setState(() {
              loading = false;
            });
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => NewsFeedPage()));
          }
          print(_location);
        }
      },
      child: Text("Update"),
      color: Colors.teal[400],
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).retrieveUserInfo,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final user = Provider.of<User>(context);
        userData = snapshot.data;
        if (snapshot.hasData) {
          return loading
              ? Loading()
              : Scaffold(
                  body: Container(
                    padding: EdgeInsets.all(16),
                    child: Form(
                        key: _formkey,
                        child: Column(children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          buildTextTitle(),
                          Divider(
                            height: 40,
                            thickness: 2,
                          ),
                          _buildFirstName(userData),
                          _buildLastName(userData),
                          _buildLocation(userData),
                          _buildPhoneNumber(userData),
                          SizedBox(
                            height: 20,
                          ),
                          _submitButton(user, userData),
                        ])),
                  ),
                );
        } else {
          return Loading();
        }
      },
    );
  }

  Row buildTextTitle() {
    return Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Edit User Details",
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ],
                        );
  }
}
