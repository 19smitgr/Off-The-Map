import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/views/partials/assignment_list.dart';
import 'package:off_the_map/views/partials/navigation_bar.dart';

class StudentAssignmentPage extends StatelessWidget {
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
              child: AssignmentList(),
            )
          ],
        ),
      ),
    );
  }
}