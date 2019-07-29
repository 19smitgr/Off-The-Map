import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/views/partials/assignment_with_options.dart';
import 'package:off_the_map/views/partials/navigation_bar.dart';

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
              child: Container(
                color: kGrayBackgroundColor,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Current Assignments',
                        style: kHeader,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    for (AssignmentWithOptions currentAssignment in assignments)
                      currentAssignment,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}