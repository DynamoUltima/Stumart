import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_app/models/user_profile.dart';
import 'package:phone_auth_app/screens/home/feed_activity.dart';
import 'package:phone_auth_app/screens/home/post_profile.dart';
import 'package:phone_auth_app/screens/navigations/notification_activity.dart';
import 'package:phone_auth_app/screens/navigations/notifications.dart';
import 'package:phone_auth_app/screens/navigations/settings.dart';
import 'package:phone_auth_app/services/database.dart';
import 'package:provider/provider.dart';

class NewsFeedPage extends StatefulWidget {
  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  List<Widget> basePages=<Widget>[FeedActivity(),NotificationArena(),Settings()];

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserProfile>>.value(
      value: DatabaseService().retrieveUserProfile,
      child: Scaffold(
        body: basePages.elementAt(_selectedIndex),
        bottomNavigationBar: buildBottomAppBar(),
        floatingActionButton: buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      tooltip: "Post your Profile",
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostProfile(),
          ),
        );
      },
      backgroundColor: Colors.teal.withOpacity(0.8),
    );
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      notchMargin: 1,
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      child: BottomNavigationBar(
        // type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Feed'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifcations'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
