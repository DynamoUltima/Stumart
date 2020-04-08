import 'dart:collection';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phone_auth_app/models/user.dart';
import 'package:phone_auth_app/models/user_data.dart';
import 'package:phone_auth_app/services/database.dart';
import 'package:phone_auth_app/shared/constants.dart';
import 'package:phone_auth_app/shared/loading.dart';
import 'package:provider/provider.dart';

class PostProfile extends StatefulWidget {
  PostProfile({Key key}) : super(key: key);

  @override
  _PostProfileState createState() => _PostProfileState();
}

class _PostProfileState extends State<PostProfile> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final dateFormat = DateFormat("EEEE, MMMM d, yyyy");

  String _gender;
  String _campus;
  DateTime _dob;
  String _interest;
  String _gpa;
  String _program;
  UserData userData;

  // Widget _buildProgram() {
  //   return TextFormField(
  //     decoration: TextDecoration.copyWith(labelText: "Program"),
  //     keyboardType: TextInputType.text,
  //     validator: (val) {
  //       if (val.isEmpty) {
  //         return "Enter Last Name";
  //       }
  //       return null;
  //     },
  //     onChanged: (val) {
  //       setState(() {
  //         _program = val;
  //       });
  //     },
  //   );
  // }

  Widget _buildProgram() {
    return FormField<String>(
      validator: (val) => val.isEmpty ? "Select an Option" : null,
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: "Program",
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
            hintText: 'Please select your program',
          ),
          isEmpty: _program== 'Select Program',
          child: Container(
            width: 300,
                      child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
               // itemHeight: 80.0,
                value: _program,
                isDense: true,
                onChanged: (String newValue) {
                  setState(() {
                    _program = newValue;
                    state.didChange(newValue);
                  });
                },
                items: CampusPrograms.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInterest() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      maxLines: 3,
      decoration: TextDecoration.copyWith(
          labelText: "Interests", border: OutlineInputBorder()),
      keyboardType: TextInputType.text,
      validator: (val) {
        if (val.isEmpty) {
          return "Field cannot be empty";
        }
        return null;
      },
      onChanged: (val) {
        setState(() {
          _interest = val;
        });
      },
    );
  }

  Widget _buildGPA() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: TextDecoration.copyWith(labelText: "GPA"),
      onChanged: (val) {
        setState(() {
          _gpa = val;
        });
      },
    );
  }

  Widget _buildGender() {
    return FormField<String>(
      validator: (val) => val.isEmpty ? "Select an Option" : null,
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: "Gender",
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
            hintText: 'Please select your gender',
          ),
          isEmpty: _gender == 'Select gender',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _gender,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  _gender = newValue;
                  state.didChange(newValue);
                });
              },
              items: genderType.map((String value) {
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

  Widget _buildCampus() {
    return FormField<String>(
      validator: (val) => val.isEmpty ? "Select an Option" : null,
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: "Campus",
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
            hintText: 'Please select your Institution',
          ),
          isEmpty: _campus == 'Select gender',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _campus,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  _campus = newValue;
                  state.didChange(newValue);
                });
              },
              items: campuses.map((String value) {
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

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  Widget _buildDob() {
    return DateTimeField(
      // showCursor: true,
      // cursorColor: Colors.blue,
      onChanged: (val) {
        setState(() {
          _dob = val;
        });

        try {
          calculateAge(val);
          print(calculateAge(val).toString());
        } catch (e) {
          print(e);
        }
        // print(_dob);
      },
      validator: (val) {
        if (val == null) {
          return "this field can't be empty";
        }
        return null;
      },
      format: dateFormat,
      decoration: TextDecoration.copyWith(labelText: "Enter date of birth"),
      onShowPicker: (context, currentValue) {
        //convert dob into age
        return showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          initialDate:
              currentValue ?? DateTime.now().subtract(Duration(days: 7365)),
          lastDate: DateTime(2100),
        );
      },
    );
  }

  Widget _submitPostButton(BuildContext context, UserData userData) {
    return FlatButton(
      color: Colors.teal,
      onPressed: () async {
        if (_formkey.currentState.validate()) {
          final user = Provider.of<User>(context, listen: false);
          Map<String, Object> postProfile = HashMap();
          postProfile.putIfAbsent("first", () => userData.first);
          postProfile.putIfAbsent("last", () => userData.last);
          postProfile.putIfAbsent("email", () => userData.email);
          postProfile.putIfAbsent("identity", () => userData.identity);
          postProfile.putIfAbsent("location", () => userData.location);
          postProfile.putIfAbsent("phone", () => userData.phone);
          postProfile.putIfAbsent("program", () => _program);
          postProfile.putIfAbsent("gender", () => _gender);
          postProfile.putIfAbsent("age", () => calculateAge(_dob).toString());
          postProfile.putIfAbsent("campus", () => _campus);
          postProfile.putIfAbsent("gpa", () => _gpa);
          postProfile.putIfAbsent("interest", () => _interest);
          postProfile.putIfAbsent("post_id", () => user.uid);

          await DatabaseService(uid: user.uid)
              .postUserProfile(postProfile)
              .then((response) {
            print(response);
          });
        }
      },
      child: Text("Submit Post"),
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).retrieveUserInfo,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        userData = snapshot.data;

        if (snapshot.hasData) {
          print(userData.email);
          return Scaffold(
            appBar: AppBar(title: Text("Post Your Profile")),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Form(
                  key: _formkey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 55,
                      ),
                      _buildInterest(),
                      _buildGPA(),
                      _buildCampus(),
                      _buildProgram(),
                      _buildDob(),
                      _buildGender(),
                      SizedBox(
                        height: 15,
                      ),
                      _submitPostButton(context, userData)
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
