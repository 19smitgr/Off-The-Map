import 'package:flutter/material.dart';
import 'package:off_the_map/assignment_page.dart';
import 'package:off_the_map/map_page.dart';
import 'package:off_the_map/place_story_page.dart';

void main() => runApp(OffTheMap());

class OffTheMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PlaceStoryPage(),
    );
  }
}


