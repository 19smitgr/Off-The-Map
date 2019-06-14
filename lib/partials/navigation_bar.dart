import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar({this.showBottomPart = true});

  bool showBottomPart;

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            // top part of app bar
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Mr. White\'s Class: Assignments',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          if (widget.showBottomPart)
            Container(
              // bottom part
              color: kLightBlueBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Local Parks',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Due April 15 at 11:59PM',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
