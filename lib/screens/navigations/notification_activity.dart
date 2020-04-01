import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_app/models/user_notifications.dart';
import 'package:phone_auth_app/models/user_profile.dart';
import 'package:phone_auth_app/shared/loading.dart';
import 'package:provider/provider.dart';

class NotificationActivity extends StatefulWidget {
  @override
  _NotificationActivityState createState() => _NotificationActivityState();
}

class _NotificationActivityState extends State<NotificationActivity> {
  @override
  Widget build(BuildContext context) {
    final userNotification = Provider.of<List<UserNotification>>(context);

    try {
      if (userNotification != null) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Notifications",textScaleFactor: 1.5,),
                ),
              ],
            ),
           
            buildNotificationListContainer(userNotification),
          ],
        );
      }
    } catch (e) {
      print(e);
    }

    return Loading();
  }

  Container buildNotificationListContainer(
      List<UserNotification> userNotification) {
    return Container(
      child: ListView.builder(
        dragStartBehavior: DragStartBehavior.start,
        scrollDirection: Axis.vertical,
        itemCount: userNotification.length ?? 0,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final note = userNotification[index];

          return ListTile(
            contentPadding: EdgeInsets.all(8.0),
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person),
              radius: 30,
            ),
            title: Text(note.notifyMessage ?? "default value"),
            subtitle: Text(note.timestamp ?? "defaultvalue"),
            dense: true,
          );
        },
      ),
    );
  }
}
