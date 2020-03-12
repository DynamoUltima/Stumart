import 'package:flutter/material.dart';
import 'package:phone_auth_app/services/auth.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth= AuthService();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.brown[100],
        elevation:0,
        title: Text("SignIn Anon"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20,horizontal:50),
        child: RaisedButton(
          child: Text("Sign In"),
          onPressed: ()async {
            dynamic result =await _auth.signInAnon();

            if(result == null){
              print("error signing in");

            }else{
              print("signed In");
              print(result.uid);
            }
          
        }),
      ),
      
    );
  }
}