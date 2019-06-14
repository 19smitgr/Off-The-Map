import 'package:flutter/material.dart';
import 'package:off_the_map/assignment_list.dart';
import 'package:off_the_map/partials/navigation_bar.dart';

import 'constants.dart';

class AssignmentPage extends StatelessWidget {
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