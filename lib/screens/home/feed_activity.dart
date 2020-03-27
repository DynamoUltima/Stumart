import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_app/models/user.dart';
import 'package:phone_auth_app/models/user_data.dart';
import 'package:phone_auth_app/models/user_profile.dart';
import 'package:phone_auth_app/services/database.dart';
import 'package:phone_auth_app/shared/loading.dart';
import 'package:provider/provider.dart';

class FeedActivity extends StatefulWidget {
  FeedActivity({Key key}) : super(key: key);

  @override
  _FeedActivityState createState() => _FeedActivityState();
}

class _FeedActivityState extends State<FeedActivity> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final post = Provider.of<QuerySnapshot>(context);

    // for (var postInfo in post.documents) {
    //   //print this if documents exist to avoid null errors
    //   if (postInfo.exists) print(postInfo.data);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final userProfiles = Provider.of<List<UserProfile>>(context);
    // if (userProfiles != null) {
      return Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: userProfiles.length,
          shrinkWrap: true,
         // physics: ClampingScrollPhysics(),
          
          itemBuilder: (context, index) {
            final profile = userProfiles[index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 20,
                    child: Icon(Icons.person),
                  ),
                  title: Text(profile.first + " " + profile.last),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(profile.campus),
                      Text(profile.program),
                    ],
                  ),
                  trailing: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.green,
                    child: Text(profile.gender.substring(0,1)),
                  ),
                  isThreeLine: true,
                
                ),
              ),
            );
          },
        ),
      );
    // }else{
    //   Container(
    //     child: Center(
    //       child:Text(" Sorry there's No Profile")
    //     ),
    //   );

    // }
  }
}
