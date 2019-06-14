import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/partials/navigation_bar.dart';

import 'assignment_page.dart';

void main() => runApp(OffTheMap());

class OffTheMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AssignmentsStudentPage(),
    );
  }
}

class AssignmentsStudentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlueBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            NavigationBar(
              showBottomPart: false,
            ),
            Expanded(
              child: AssignmentPage(),
            )
          ],
        ),
      ),
    );
  }
}
