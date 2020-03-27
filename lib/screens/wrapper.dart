import 'package:flutter/material.dart';
import 'package:phone_auth_app/models/user.dart';
import 'package:phone_auth_app/screens/authenticate/authenticate.dart';
import 'package:phone_auth_app/screens/home/home.dart';
import 'package:phone_auth_app/screens/home/intro.dart';
import 'package:provider/provider.dart';



class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);
    

   if(user == null){
     return Authenticate();//Intro( should be here)
   } else{
     return Intro();//this should be reversed but may be lept so for testing purposes  
     //News activity should be here

     //Home();
   }


    // return Authenticate();
  }
}