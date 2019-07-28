import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/models/class.dart';
import 'package:off_the_map/models/user.dart';
import 'package:off_the_map/objects/named_reference.dart';
import 'package:off_the_map/views/class_page.dart';
import 'package:off_the_map/views/create_new_class.dart';
import 'package:off_the_map/views/teacher_assignment_page.dart';

class TeacherHome extends StatelessWidget {
  final Color veryDarkBlue = Color(0xFF30465C);
  final Color purple = Color(0xFF93639A);
  final User user;

  TeacherHome({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrayBackgroundColor,
      appBar: AppBar(
        title: Text('Teacher Home'),
        backgroundColor: veryDarkBlue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return TeacherAssignmentPage(user: this.user);
                  }),
                );
              },
              child: Text(
                'Assignment Bank',
                style: TextStyle(color: Colors.white),
              ),
              color: purple,
            ),
          ),
          Center(child: Text('Your Classes', style: kHeader)),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CreateNewClassPage(user: this.user);
                    },
                  ),
                );
              },
              color: veryDarkBlue,
              child: Text('New Class', style: TextStyle(color: Colors.white)),
            ),
          ),
          for (NamedReference classReference in this.user.createdClasses)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RaisedButton(
                onPressed: () async {
                  DocumentSnapshot classSnap =
                      await classReference.reference.get();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ClassPage(
                          schoolClass: Class.fromFirestore(classSnap),
                        );
                      },
                    ),
                  );
                },
                color: purple,
                child: Text(
                  classReference.name,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
        ],
      ),
    );
  }
}
