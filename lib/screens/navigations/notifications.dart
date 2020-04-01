import 'package:flutter/material.dart';
import 'package:phone_auth_app/models/user.dart';
import 'package:phone_auth_app/models/user_notifications.dart';
import 'package:phone_auth_app/screens/navigations/notification_activity.dart';
import 'package:phone_auth_app/services/database.dart';
import 'package:provider/provider.dart';

class NotificationArena extends StatefulWidget {
  @override
  _NotificationArenaState createState() => _NotificationArenaState();
}

class _NotificationArenaState extends State<NotificationArena> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<List<UserNotification>>.value(
      value: DatabaseService(uid: user.uid).retrieveUserNotifications,
      child: Scaffold(body: NotificationActivity()),
    );
  }
}
