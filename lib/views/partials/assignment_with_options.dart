import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/models/assignment.dart';

/// Used to create an assignment that has multiple links that perform a given function
class AssignmentWithOptions extends StatelessWidget {
  final Map<String, Function> options;
  final Assignment assignment;

  AssignmentWithOptions({this.assignment, this.options});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.assignment.name,
            style: kSubtitleStyle,
            textAlign: TextAlign.left,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 10.0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: <Widget>[
                for(String key in options.keys)
                  FlatButton(
                    onPressed: () {
                      options[key](assignment, context);
                    },
                    child: Text(
                      key,
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
