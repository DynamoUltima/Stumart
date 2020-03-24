import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),

        )],
      ),
    );
  }
}
