import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/models/assignment.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/models/user.dart';
import 'package:off_the_map/objects/named_reference.dart';
import 'package:off_the_map/views/partials/assignment_with_options.dart';
import 'package:off_the_map/views/partials/navigation_bar.dart';
import 'package:off_the_map/views/student_complete_assignment_page.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: kGrayBackgroundColor,
              child: FutureBuilder(
                future: loadAssignments(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Assignment>> snap) {
                  switch (snap.connectionState) {
                    case ConnectionState.waiting:
                      return Text('Loading...');
                    default:
                      print(snap.connectionState);
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
                                  'Complete Assignment': (Assignment assignment,
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
                                  }
                                },
                              ),
                          ],
                        );
                      }
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
