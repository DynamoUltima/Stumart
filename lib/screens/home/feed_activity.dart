import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_app/models/user.dart';

import 'package:phone_auth_app/models/user_profile.dart';
import 'package:phone_auth_app/screens/home/details.dart';
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

    //McContainer.elementAt(_selectedIndex),
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User>(context);
    double screenHeight = MediaQuery.of(context).size.height;

    final userProfiles = Provider.of<List<UserProfile>>(context) ?? [];

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: screenHeight * 0.05),
          SizedBox(height: 10),
          buildSearch(),
          SizedBox(height: 10),
          buildProfileText(),
          Divider(
            thickness: 2,
          ),
          buildProfileListContainer(userProfiles),
        ],
      ),
    );
  }

  Widget buildProfileListContainer(List<UserProfile> userProfiles) {
    if (userProfiles.length != null) {
      

      return Container(
        child: ListView.builder(
          dragStartBehavior: DragStartBehavior.start,
          scrollDirection: Axis.vertical,
          itemCount: userProfiles.length ?? 0,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            final profile = userProfiles[index];
           

            return ProfileTile(profile: profile);
          },
        ),
      );
    }
    return Loading();
  }

  Row buildProfileText() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "Profiles",
            textScaleFactor: 1.5,
          ),
        ),
      ],
    );
  }

  Padding buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        // controller: editingController,
        decoration: InputDecoration(
            isDense: true,
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)))),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    Key key,
    @required this.profile,
  }) : super(key: key);

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailsPage(
                  profile: profile,
                ),
              ),
            );
          },
          contentPadding: EdgeInsets.all(8.0),
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 20,
            child: Icon(Icons.person),
          ),
          title: Text(
            profile.first + " " + profile.last,
            textScaleFactor: 1.01,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(profile.campus),
                  Text(
                    profile.program,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Text(profile.email),
                  ],
                ),
              ),
            ],
          ),
          trailing: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.green,
            child: Text(profile.gender.substring(0, 1)),
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
