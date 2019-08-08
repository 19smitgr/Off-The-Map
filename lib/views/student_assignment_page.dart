import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/controllers/action_status_controller.dart';
import 'package:off_the_map/models/assignment.dart';
import 'package:off_the_map/models/class.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/models/user.dart';
import 'package:off_the_map/objects/named_reference.dart';
import 'package:off_the_map/views/partials/action_status.dart';
import 'package:off_the_map/views/partials/assignment_with_options.dart';
import 'package:off_the_map/views/partials/navigation_bar.dart';
import 'package:off_the_map/views/student_complete_assignment_page.dart';
import 'package:provider/provider.dart';

class StudentAssignmentPage extends StatelessWidget {
  final List<AssignmentWithOptions> assignments = [
    // AssignmentWithOptions(
    //   title: 'Stuff and Things',
    //   options: {
    //     'Work on Assignment': StudentAssignmentPage(),
    //     'Publish Work': Container(),
    //     'Submit Assignment': Container(),
    //   },
    // ),
  ];

  final User user;

  StudentAssignmentPage({@required this.user});

  Future<List<Assignment>> loadAssignments() async {
    List<Assignment> assignments = [];

    for (NamedReference schoolClass in this.user.joinedClasses) {
      QuerySnapshot qs =
          await Firestore.instance.collection('assignments').where(
        'classesAssignedTo',
        arrayContains: {
          'name': schoolClass.name,
          'reference': schoolClass.reference,
        },
      ).getDocuments();

      for (DocumentSnapshot doc in qs.documents) {
        assignments.add(
          Assignment.fromFirestore(doc),
        );
      }
    }

    return assignments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlueBackground,
      appBar: AppBar(
        title: Text('Your Assignments'),
        backgroundColor: kDarkBlueBackground,
      ),
      body: Container(
        color: kGrayBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: kPurple,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return JoinClassPage(user: this.user);
                      },
                    ),
                  );
                },
                child: Text(
                  'Join Class',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: loadAssignments(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Assignment>> snap) {
                  switch (snap.connectionState) {
                    case ConnectionState.waiting:
                      return Text('Loading...');
                    default:
                      if (snap.hasError) {
                        return Text('Error: ${snap.error}');
                      } else {
                        return ListView(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Current Assignments',
                                style: kHeader,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            for (Assignment assignment in snap.data)
                              AssignmentWithOptions(
                                assignment: assignment,
                                options: {
                                  'Work on Assignment': (Assignment assignment,
                                      BuildContext context) async {
                                    QuerySnapshot qs = await Firestore.instance
                                        .collection('places')
                                        .where(
                                      'assignmentRefs',
                                      arrayContains: {
                                        'name': assignment.name,
                                        'reference': assignment.reference
                                      },
                                    ).getDocuments();

                                    List<Place> places = [];

                                    for (DocumentSnapshot snap
                                        in qs.documents) {
                                      places.add(
                                        Place.fromFirestore(snap),
                                      );
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
                                  'Submit Assignment': (Assignment assignment, BuildContext context) {
                                    // loop through uncompletedAssignment and turn into places
                                  }
                                },
                              ),
                          ],
                        );
                      }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class JoinClassPage extends StatelessWidget {
  final TextEditingController classCodeController = TextEditingController();
  final ActionStatusController actionStatusController =
      ActionStatusController();

  final User user;

  JoinClassPage({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlueBackground,
        title: Text('Join Class'),
      ),
      body: Container(
        child: ChangeNotifierProvider<ActionStatusController>.value(
          value: actionStatusController,
          child: Consumer<ActionStatusController>(
            builder: (BuildContext context,
                ActionStatusController actionStatusController, Widget child) {
              return Column(
                children: <Widget>[
                  if (actionStatusController.visible) ActionStatus(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: classCodeController,
                      decoration: InputDecoration(
                        hintText: 'Enter Class Code',
                        labelText: 'Class Code',
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: kPurple,
                    onPressed: () async {
                      try {
                        QuerySnapshot qs = await Firestore.instance
                            .collection('classes')
                            .where('code', isEqualTo: classCodeController.text)
                            .getDocuments();

                        if (qs.documents.isNotEmpty) {
                          Class schoolClass =
                              Class.fromFirestore(qs.documents[0]);

                          user.joinedClasses.add(
                            NamedReference(
                              name: schoolClass.name,
                              reference: schoolClass.reference,
                            ),
                          );

                          Navigator.pop(context);
                        } else {
                          actionStatusController.error(
                            message: 'Incorrect or Invalid Code',
                          );
                        }
                      } catch (e) {
                        actionStatusController.error(
                          message: 'Incorrect or Invalid Code',
                        );
                      }
                    },
                    child:
                        Text('Submit', style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
