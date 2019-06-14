import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';

class AssignmentPage extends StatefulWidget {
  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  List<AssignmentWithOptions> assignments = [
    AssignmentWithOptions(),
    AssignmentWithOptions(),
    AssignmentWithOptions(),
    AssignmentWithOptions(),
  ];

  List<AssignmentWithOptions> pastAssignments = [
    AssignmentWithOptions(),
    AssignmentWithOptions(),
    AssignmentWithOptions(),
    AssignmentWithOptions(),
    AssignmentWithOptions(),
    AssignmentWithOptions(),
    AssignmentWithOptions(),
    AssignmentWithOptions(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Past Assignments',
              style: kHeader,
              textAlign: TextAlign.center,
            ),
          ),
          for (AssignmentWithOptions pastAssignment in pastAssignments)
            pastAssignment,
        ],
      ),
    );
  }
}

class AssignmentWithOptions extends StatefulWidget {
  @override
  _AssignmentWithOptionsState createState() => _AssignmentWithOptionsState();
}

class _AssignmentWithOptionsState extends State<AssignmentWithOptions> {
  String title = 'Local Parks';
  List<String> options = [
    'Work on Assignment',
    'Publish Work',
    'Submit Assignment',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: kSubtitleStyle,
            textAlign: TextAlign.left,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 10.0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: <Widget>[
                for (String option in options)
                  Text(
                    option,
                    style: kAssignmentOptionStyle,
                  ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
