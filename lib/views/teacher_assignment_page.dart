import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/controllers/current_place_controller.dart';
import 'package:off_the_map/models/assignment.dart';
import 'package:off_the_map/models/class.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/models/story.dart';
import 'package:off_the_map/models/user.dart';
import 'package:off_the_map/objects/named_reference_list.dart';
import 'package:off_the_map/views/partials/assignment_with_options.dart';
import 'package:off_the_map/views/place_story_page.dart';
import 'package:off_the_map/views/student_assignment_page.dart';

class TeacherAssignmentPage extends StatelessWidget {
  final User user;

  TeacherAssignmentPage({@required this.user});

  @override
  Widget build(BuildContext context) {
    final Map<String, Function> assignmentOptions = {
      'See Submissions': (Assignment assignment, BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ClassSelectionPage(
                user: this.user,
                assignment: assignment,
              );
            },
          ),
        );
      },
      'Preview': (Assignment assignment, BuildContext context) {
        return StudentAssignmentPage();
      },
      'Assign to a Class': (Assignment assignment, BuildContext context) {
        return Container();
      },
      'Delete': (Assignment assignment, BuildContext context) {
        return Container();
      },
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment Bank'),
        backgroundColor: kVeryDarkBlue,
      ),
      body: Container(
        color: kGrayBackgroundColor,
        child: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection('assignments')
              .where('ownerReference', isEqualTo: this.user.reference)
              .getDocuments(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading...');
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      Assignment assignment = Assignment.fromFirestore(
                          snapshot.data.documents[index]);
                      return AssignmentWithOptions(
                        assignment: assignment,
                        options: assignmentOptions,
                      );
                    },
                  );
            }
          },
        ),
      ),
    );
  }
}

class ClassSelectionPage extends StatelessWidget {
  final User user;
  final Assignment assignment;

  ClassSelectionPage({@required this.user, @required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Class'),
        backgroundColor: kVeryDarkBlue,
      ),
      body: Container(
        color: kGrayBackgroundColor,
        child: ListView.builder(
          itemCount: this.user.createdClasses.length,
          itemBuilder: (BuildContext context, int index) {
            return RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return FutureBuilder<DocumentSnapshot>(
                          future:
                              this.user.createdClasses[index].reference.get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Container(
                                  color: kGrayBackgroundColor,
                                  child: Text('Loading...'),
                                );
                              default:
                                if (snapshot.hasError)
                                  return Text('Error: ${snapshot.error}');
                                else
                                  return StudentSelectionPage(
                                    schoolClass:
                                        Class.fromFirestore(snapshot.data),
                                    assignment: this.assignment,
                                  );
                            }
                          });
                    },
                  ),
                );
              },
              child: Text(this.user.createdClasses[index].name),
            );
          },
        ),
      ),
    );
  }
}

class StudentSelectionPage extends StatelessWidget {
  final Class schoolClass;
  final Assignment assignment;

  StudentSelectionPage({@required this.schoolClass, @required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Student'),
        backgroundColor: kDarkBlueBackground,
      ),
      body: ListView.builder(
          itemCount: this.schoolClass.users.length,
          itemBuilder: (BuildContext context, int index) {
            return RaisedButton(
              onPressed: () async {
                DocumentSnapshot userDoc =
                    await this.schoolClass.users[index].reference.get();
                User user = User.fromFirestore(userDoc);

                List<Place> places = [];
                print(user.completedAssignments[0].referenceList);
                for (NamedReferenceList assignment
                    in user.completedAssignments) {
                  print(assignment.name);
                  print(this.assignment.reference);
                  if (assignment.name == this.assignment.reference) {
                    // loop through each place
                    for (DocumentReference placeRef
                        in assignment.referenceList) {
                      DocumentSnapshot placeSnapshot = await placeRef.get();

                      places.add(Place.fromFirestore(placeSnapshot));
                    }
                  }
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return PlacePicker(places: places);
                    },
                  ),
                );
              },
              child: Text(
                this.schoolClass.users[index].name,
              ),
            );
          }),
    );
  }
}

class PlacePicker extends StatelessWidget {
  final List<Place> places;

  PlacePicker({@required this.places});

  @override
  Widget build(BuildContext context) {
    print(places);
    return Scaffold(
      appBar: AppBar(
          title: Text('Choose a place'), backgroundColor: kDarkBlueBackground),
      body: ListView(
        children: <Widget>[
          for (Place place in places)
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ViewPlaceTopics(place: place);
                    },
                  ),
                );
              },
              child: Text(place.name),
            ),
        ],
      ),
    );
  }
}

class ViewPlaceTopics extends StatelessWidget {
  final Place place;

  ViewPlaceTopics({@required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topics'),
        backgroundColor: kDarkBlueBackground,
      ),
      body: ListView(
        children: <Widget>[
          for (NamedReferenceList topicRef in place.topics)
            RaisedButton(
              onPressed: () async {
                List<Story> stories = [];

                for (DocumentReference storyRef in topicRef.referenceList) {
                  DocumentSnapshot storySnap = await storyRef.get();
                  Story story = Story.fromFirestore(storySnap);
                  stories.add(story);
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      print(place.name);

                      return PlaceStoryPage(
                        topic: topicRef.name,
                        stories: stories,
                        currentPlaceController:
                            CurrentPlaceController(currentPlace: this.place),
                      );
                    },
                  ),
                );
              },
              child: Text(topicRef.name),
            ),
        ],
      ),
    );
  }
}
