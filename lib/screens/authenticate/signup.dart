import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:phone_auth_app/screens/home/news_feed.dart';
import 'package:phone_auth_app/services/auth.dart';
import 'package:phone_auth_app/services/database.dart';
import 'package:phone_auth_app/shared/constants.dart';
import 'package:phone_auth_app/shared/loading.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _firstName;
  String _lastName;
  String _email;
  String _password;
  String _phoneNumber;
  String _program;
  String _location;

  var _categories = ["Student", "Company", "Not Student"];

  String _identityValue;
  bool loading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  Widget _buildFirstName() {
    return TextFormField(
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

  Widget _buildLastName() {
    return TextFormField(
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

  Widget _buildPassword() {
    return TextFormField(
      decoration: TextDecoration.copyWith(labelText: "Password"),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: (val) {
        if (val.isEmpty) {
          return "Enter Last Name";
        }
        return null;
      },
      onChanged: (val) {
        setState(() {
          _password = val;
        });
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: TextDecoration.copyWith(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      validator: (val) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(val)) {
          return "Enter Valid Email";
        }
        return null;
      },
      onChanged: (val) {
        setState(() {
          _email = val;
        });
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
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

  Widget _buildProgram() {
    return TextFormField(
      decoration: TextDecoration.copyWith(labelText: "Program"),
      keyboardType: TextInputType.text,
      validator: (val) {
        if (val.isEmpty) {
          return "Enter Last Name";
        }
        return null;
      },
      onChanged: (val) {
        setState(() {
          _program = val;
        });
      },
    );
  }

  Widget _buildLocation() {
    return TextFormField(
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

  Widget _buildIdentity() {
    return FormField<String>(
      validator: (val) => val.isEmpty ? "Select an Option" : null,
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            //labelStyle: textStyle,
            labelText: "Identity",
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
            hintText: 'Please select your Identity',
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(5.0),
            // ),
          ),
          isEmpty: _identityValue == 'Enter Your Identity',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _identityValue,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  _identityValue = newValue;
                  state.didChange(newValue);
                });
              },
              items: _categories.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _submitButton() {
    return FlatButton(
      onPressed: () async {
        if (_formkey.currentState.validate()) {
          setState(() => loading = true);

          Map<String, Object> userInfo = HashMap();
          userInfo.putIfAbsent("first", () => _firstName);
          userInfo.putIfAbsent("last", () => _lastName);
          userInfo.putIfAbsent("email", () => _email);
          userInfo.putIfAbsent("phone", () => _phoneNumber);
          userInfo.putIfAbsent("program", () => _program);
          userInfo.putIfAbsent("location", () => _location);
          userInfo.putIfAbsent("identity", () => _identityValue);

          dynamic result =
              await _auth.createWithEmailAndPassword(_email, _password);
          await DatabaseService(uid: result.uid).updateUserData(userInfo);

          if (result == null) {
            setState(() {
              loading = false;
            });
            print("error signing in");
          } else {
            print(result.uid);
            setState(() {
              loading = false;
            });
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => NewsFeedPage()));
          }
          print(_location);
        }
      },
      child: Text("Submit"),
      color: Colors.teal[400],
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            //work on popup toast bar to display error signin in with firebase
            appBar: AppBar(
              title: Text("Sign Up Form"),
              backgroundColor: Colors.teal[400],
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Column(
                      children: <Widget>[
                        _buildFirstName(),
                        _buildLastName(),
                        _buildEmail(),
                        _buildPassword(),
                        _buildPhoneNumber(),
                        _buildIdentity(),
                        _buildLocation(),
                        _buildProgram(),
                        SizedBox(
                          height: 15,
                        ),
                        _submitButton()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
