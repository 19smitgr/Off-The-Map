import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/models/user.dart';
import 'package:off_the_map/objects/named_reference.dart';
import 'package:off_the_map/views/student_assignment_page.dart';
import 'package:off_the_map/views/teacher_home.dart';

/// a User's profile page. Does not yet link to their stories pages within the app.
class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlueBackground,
        title: Text(user.name),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: kPurple,
              onPressed: () {
                // TODO: make them enter a code that they paid for
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return TeacherHome(user: this.user);
                    },
                  ),
                );
              },
              child: Text(
                'Teacher Pages',
                style: TextStyle(color: Colors.white),
              ),
            ),
            RaisedButton(
              color: kPurple,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return StudentAssignmentPage(user: this.user);
                    },
                  ),
                );
              },
              child: Text(
                'Student Pages',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text('Stories I Wrote'),
            for (NamedReference storyRef in user.createdStories)
              Text(storyRef.name),
          ],
        ),
      ),
    );
  }
}
