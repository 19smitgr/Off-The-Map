import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/models/class.dart';
import 'package:off_the_map/objects/named_reference.dart';

/// The page for a teacher's class.
class ClassPage extends StatelessWidget {
  final Class schoolClass;

  ClassPage({@required this.schoolClass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrayBackgroundColor,
      appBar: AppBar(
        backgroundColor: kDarkBlueBackground,
        title: Text(schoolClass.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Class Code: ${schoolClass.code}',
                style: kHeader,
              ),
            ),
          ),
          if (schoolClass.users.length == 0)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('No students showing up? Have them enter your class code in the class sign up screen!'),
            ),
          for (NamedReference userRef in schoolClass.users)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RaisedButton(
                color: kPurple,
                onPressed: () {
                  // TODO: link to their user profile
                },
                child: Text(
                  userRef.name,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
