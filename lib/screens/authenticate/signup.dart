import 'package:flutter/material.dart';
import 'package:phone_auth_app/shared/constants.dart';

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

  Widget _buildFirstName() {
    return TextFormField(
      decoration: textDecoration.copyWith(labelText: "FirstName"),
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
      decoration: textDecoration.copyWith(labelText: "Last Name"),
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
      decoration: textDecoration.copyWith(labelText: "Password"),
      keyboardType:TextInputType.visiblePassword ,
      obscureText:true,
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

  Widget _buildEmail() {
    return TextFormField(
      decoration: textDecoration.copyWith(labelText: "Email"),
      validator: (val) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(val) == false) {
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

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Form"),
        backgroundColor: Colors.teal[400],
      ),
      body: Container(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(children: <Widget>[
              _buildFirstName(),
              _buildLastName(),
              _buildEmail(),
              _buildPassword()
            ],),
          ),
        ),
      ),
    );
  }
}
