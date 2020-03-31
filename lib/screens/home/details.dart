import 'package:flutter/material.dart';
import 'package:phone_auth_app/models/user_profile.dart';

class DetailsPage extends StatefulWidget {

  final UserProfile profile;

  DetailsPage({Key key, this.profile}) : super(key: key);
 

  
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var personalInfoText = Row(
    children: <Widget>[
      Text("Personal Info",textScaleFactor: 1.5,),
    ],
  );

  var otherDetailsText = Row(
    children: <Widget>[
      Text("Other Details",textScaleFactor: 1.5,),
    ],
  );
  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal:16.0),
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
            buildOtherInfo()
          ],
        ),
      ),
    );
  }

  Widget BuildInterestCard(){
     return Card(
       child: Container(
         child:Column(
           children: <Widget>[
             Row(
                children: <Widget>[
                  Icon(Icons.star, color: Colors.white),
                   SizedBox(width: 8,),
                  Text(
                    "Interest",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
              SizedBox(height:25),
              Row(
                children: <Widget>[
                  Icon(Icons.star, color: Colors.white),
                   SizedBox(width: 8,),
                  Text(
                    widget.profile.interest,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ],
              ),


         ],)
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
                  SizedBox(width: 8,),
                  Text(
                    widget.profile.identity,
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
                  SizedBox(width: 8,),
                  Text(
                    widget.profile.campus,
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
                   SizedBox(width: 8,),
                  Text(
                    widget.profile.program,
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
                   SizedBox(width: 8,),
                  Text(
                    widget.profile.interest,
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
                   SizedBox(width: 8,),
                  Text(
                    widget.profile.gpa,
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
                   SizedBox(width: 8,),
                  Text(
                    widget.profile.first+" "+widget.profile.last,
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
                   SizedBox(width: 8,),
                  Text(
                    widget.profile.email,
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
                   SizedBox(width: 8,),
                  Text(
                    widget.profile.location,
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
                   SizedBox(width: 8,),
                  Text(
                    widget.profile.phone,
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
                   SizedBox(width: 8,),
                  Text(
                    widget.profile.gender,
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
