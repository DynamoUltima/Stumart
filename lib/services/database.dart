import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_auth_app/models/user_data.dart';
import 'package:phone_auth_app/models/user_notifications.dart';
import 'package:phone_auth_app/models/user_profile.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection("Users");

  final CollectionReference postCollection =
      Firestore.instance.collection("Posts");

  Future updateUserInfo(Map userDataInfo) async {
    return await userCollection.document(uid).updateData(userDataInfo);
  }

  Future updateUserData(Map userInfo) async {
    return await userCollection.document(uid).setData(userInfo);
  }

  Future postUserProfile(Map postProfile) async {
    return await postCollection.document(uid).setData(postProfile);
  }

  Future notifyUser(Map notify, String notId) async {
    final CollectionReference notificationCollection =
        Firestore.instance.collection("Users/" + notId + "/Notifications");
    return await notificationCollection.document(uid).setData(notify);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      email: snapshot.data['email'] ?? "",
      first: snapshot.data['first'] ?? "",
      identity: snapshot.data['identity'] ?? "",
      last: snapshot.data['last'] ?? "",
      location: snapshot.data['location'] ?? "",
      phone: snapshot.data['phone'] ?? "",
      // program: snapshot.data['program'] ?? "",
    );
  }

  List<UserNotification> _userNotificationFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserNotification(
        notifyMessage: doc.data["notifyMessage"] ?? "",
        timestamp: doc.data["timestamp"] ?? "",
      );
    }).toList();
  }

  List<UserProfile> _userProfileListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserProfile(
        first: doc.data['first'] ?? "",
        last: doc.data['last'] ?? "",
        email: doc.data['email'] ?? "",
        gender: doc.data['gender'] ?? "",
        campus: doc.data['campus'] ?? "",
        program: doc.data['program'] ?? "",
        age: doc.data["age"] ?? "",
        phone: doc.data["phone"] ?? "",
        location: doc.data["location"] ?? "",
        gpa: doc.data["gpa"] ?? "",
        postId: doc.data["post_id"] ?? "",
        interest: doc.data["interest"] ?? "",
      );
    }).toList();
  }

  Stream<UserData> get retrieveUserInfo {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<QuerySnapshot> get retrievePost {
    return postCollection.snapshots();
  }

  Stream<List<UserProfile>> get retrieveUserProfile {
    return postCollection.snapshots().map(_userProfileListFromSnapShot);
  }

  Stream<List<UserNotification>> get retrieveUserNotifications {
    final CollectionReference notificationCollection =
        Firestore.instance.collection("Users/" + uid + "/Notifications");
    return notificationCollection
        .snapshots()
        .map(_userNotificationFromSnapshot);
  }
}
