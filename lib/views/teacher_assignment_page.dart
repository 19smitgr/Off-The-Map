import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/controllers/action_status_controller.dart';
import 'package:off_the_map/controllers/current_place_controller.dart';
import 'package:off_the_map/models/assignment.dart';
import 'package:off_the_map/models/class.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/models/story.dart';
import 'package:off_the_map/models/user.dart';
import 'package:off_the_map/objects/named_reference.dart';
import 'package:off_the_map/objects/named_reference_list.dart';
import 'package:off_the_map/views/create_assignment_page.dart';
import 'package:off_the_map/views/partials/action_status.dart';
import 'package:off_the_map/views/partials/assignment_with_options.dart';
import 'package:off_the_map/views/place_story_page.dart';
import 'package:off_the_map/views/student_complete_assignment_page.dart';
import 'package:provider/provider.dart';

class TeacherAssignmentPage extends StatelessWidget {
  final User user;
  final ActionStatusController actionStatusController =
      ActionStatusController();

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
                  classes: this.user.createdClasses,
                  onClassSelect: (NamedReference classRef) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return FutureBuilder<DocumentSnapshot>(
                            future: classRef.reference.get(),
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
                                      assignment: assignment,
                                    );
                              }
                            },
                          );
                        },
                      ),
                    );
                  });
            },
          ),
        );
      },
      'Preview': (Assignment assignment, BuildContext context) async {
        // TODO: soooo inefficient
        QuerySnapshot placeSnap = await Firestore.instance
            .collection('places')
            .where('assignmentRefs', arrayContains: {
          'name': assignment.name,
          'reference': assignment.reference
        }).getDocuments();

        List<Place> places = [];

        for (DocumentSnapshot snap in placeSnap.documents) {
          places.add(Place.fromFirestore(snap));
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return StudentCompleteAssignmentPage(
                places: places,
                assignment: assignment,
              );
            },
          ),
        );
      },
      'Assign to a Class': (Assignment assignment, BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ClassSelectionPage(
                classes: this.user.createdClasses,
                onClassSelect: (NamedReference classRef) async {
                  try {
                    // add this class to the assignment in firestore
                    await assignment.reference.updateData({
                      "classesAssignedTo": FieldValue.arrayUnion([
                        {'name': classRef.name, 'reference': classRef.reference}
                      ]),
                    });

                    Navigator.pop(context);

                    actionStatusController.success(message: 'Successful!');
                  } catch (e) {
                    Navigator.pop(context);

                    actionStatusController.error(
                      message:
                          'Something went wrong :( Here\'s the error message:\n\n$e',
                    );
                  }
                },
              );
            },
          ),
        );
      },
      'Delete': (Assignment assignment, BuildContext context) async {
        try {
          await assignment.reference.delete();
          actionStatusController.success(message: 'Successful!');
        } catch (e) {
          actionStatusController.error(
            message: 'Something went wrong :( Here\'s the error message:\n\n$e',
          );
        }
      },
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment Bank'),
        backgroundColor: kVeryDarkBlue,
      ),
      body: Container(
        color: kGrayBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                color: kPurple,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return CreateAssignmentPage();
                      },
                    ),
                  );
                },
                child: Text(
                  'Create New Assignment',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ChangeNotifierProvider(
              builder: (BuildContext context) => actionStatusController,
              child: ActionStatus(),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection('assignments')
                  .where('ownerReference', isEqualTo: this.user.reference)
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
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            Assignment assignment = Assignment.fromFirestore(
                                snapshot.data.documents[index]);
                            return AssignmentWithOptions(
                              assignment: assignment,
                              options: assignmentOptions,
                            );
                          },
                        ),
                      );
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

typedef void TakesNamedReference(NamedReference classRef);

class ClassSelectionPage extends StatelessWidget {
  final TakesNamedReference onClassSelect;
  final List<NamedReference> classes;

  ClassSelectionPage({@required this.classes, @required this.onClassSelect});

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
          itemCount: classes.length,
          itemBuilder: (BuildContext context, int index) {
            return RaisedButton(
              onPressed: () {
                onClassSelect(classes[index]);
              },
              child: Text(classes[index].name),
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

                for (NamedReferenceList assignment
                    in user.completedAssignments) {
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
