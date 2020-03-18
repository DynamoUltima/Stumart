import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_app/screens/home/feed_activity.dart';
import 'package:phone_auth_app/services/database.dart';
import 'package:provider/provider.dart';

class NewsFeedPage extends StatefulWidget {
  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().retrievePost,
          child: Scaffold(
            body:FeedActivity(),
      ),
    );
  }
}