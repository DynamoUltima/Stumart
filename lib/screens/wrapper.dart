import 'package:flutter/material.dart';
import 'package:phone_auth_app/models/user.dart';
import 'package:phone_auth_app/screens/authenticate/authenticate.dart';
import 'package:phone_auth_app/screens/home/home.dart';
import 'package:provider/provider.dart';



class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

   if(user == null){
     return Authenticate();
   } else{
     return Home();
   }


    return Authenticate();
  }
}