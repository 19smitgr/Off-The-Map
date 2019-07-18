import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/views/student_view_map_page.dart';

class AssignmentList extends StatelessWidget {
  final List<AssignmentWithOptions> assignments = [
    AssignmentWithOptions(),
    AssignmentWithOptions(),
    AssignmentWithOptions(),
    AssignmentWithOptions(),
  ];

  final List<AssignmentWithOptions> pastAssignments = [
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

class AssignmentWithOptions extends StatelessWidget {
  final String title = 'Local Parks';
  final List<String> options = [
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
                  if (option == 'Work on Assignment')
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentViewMapPage(),
                          ),
                        );
                      },
                      child: Text(
                        option,
                        style: kAssignmentOptionStyle,
                      ),
                    )
                  else
                    FlatButton(
                      onPressed: () {},
                      child: Text(
                        option,
                        style: kAssignmentOptionStyle,
                      ),
                    )
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
