import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/models/story.dart';
import 'package:off_the_map/models/user.dart';
import 'package:off_the_map/views/create_place_story_page.dart';
import 'package:off_the_map/views/explore_map_page.dart';
import 'package:off_the_map/views/login_page.dart';
import 'package:off_the_map/views/map_settings_page.dart';
import 'package:off_the_map/views/profile_page.dart';

class HomePage extends StatelessWidget {
  Story story = Story(
      text: 'Stuff and things',
      dateWritten: DateTime.now(),
      topic: 'This is a topic');
  List<Story> stories;

  HomePage() {
    stories = [
      Story(
          text: 'Lorem ipsum dolor sit amet...',
          dateWritten: DateTime.now(),
          topic: 'Origins of Off the Map'),
      Story(
          text: 'Lorem ipsum dolor sit amet...',
          dateWritten: DateTime.now(),
          topic: 'Expectations vs Reality'),
      Story(
          text: 'Lorem ipsum dolor sit amet...',
          dateWritten: DateTime.now(),
          topic: 'Rivers of Local Parks'),
      Story(
          text: 'Lorem ipsum dolor sit amet...',
          dateWritten: DateTime.now(),
          topic: 'Community Enjoyment'),
      Story(
          text: 'Lorem ipsum dolor sit amet...',
          dateWritten: DateTime.now(),
          topic: 'Cultural Attitude'),
      Story(
          text: 'Lorem ipsum dolor sit amet...',
          dateWritten: DateTime.now(),
          topic: 'County Schools'),
      Story(
          text: 'Lorem ipsum dolor sit amet...',
          dateWritten: DateTime.now(),
          topic: 'Public Communication'),
      Story(
          text: 'Lorem ipsum dolor sit amet...',
          dateWritten: DateTime.now(),
          topic: 'National Recognition'),
      Story(
          text: 'Lorem ipsum dolor sit amet...',
          dateWritten: DateTime.now(),
          topic: 'Organizations'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrayBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Near You',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            letterSpacing: 1.3, // based on personal preference
          ),
        ),
        backgroundColor: kDarkBlueBackground,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MapSettingsPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: stories.length,
        itemBuilder: (BuildContext context, int index) {
          return StoryCard(stories[index]);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPurple,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ExploreMapPage();
              },
            ),
          );
        },
        child: Icon(Icons.map),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(100, 255, 255, 255),
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                FirebaseUser user = await FirebaseAuth.instance.currentUser();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      if (user == null) {
                        return LoginPage();
                      } else {
                        return FutureBuilder(
                          future: Firestore.instance
                              .collection('users')
                              .where('uid', isEqualTo: user.uid)
                              .getDocuments(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Text('Loading...');
                              default:
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  // we're assuming there's only one user with this uid
                                  DocumentSnapshot doc =
                                      snapshot.data.documents[0];

                                  User user = User.fromFirestore(doc);

                                  return ProfilePage(user: user);
                                }
                            }
                          },
                        );
                      }
                    },
                  ),
                );
              },
              icon: Icon(Icons.account_circle),
              label: Text('Profile'),
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CreatePlaceStoryPage();
                    },
                  ),
                );
              },
              icon: Icon(Icons.create),
              label: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryCard extends StatelessWidget {
  final Story story;

  StoryCard(this.story);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(50, 0, 0, 0),
              offset: Offset(4.0, 4.0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Material(
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.account_circle, size: 32.0),
                    SizedBox(width: 16.0),
                    Column(
                      children: <Widget>[Text(story.topic), Text(story.text)],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
