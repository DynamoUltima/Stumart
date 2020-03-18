import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
    final String uid;

  DatabaseService({ this.uid });
  

  final CollectionReference userCollection =Firestore.instance.collection("Users");
  final CollectionReference postCollection =Firestore.instance.collection("Posts");
   

   Future updateUserData(Map userInfo) async {

     return await  userCollection.document(uid).setData(userInfo);

   }

   Stream<QuerySnapshot> get retrievePost{
     return postCollection.snapshots();
   }

}