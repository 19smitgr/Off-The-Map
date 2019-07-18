import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:off_the_map/explore_map_page.dart';

void main() => runApp(OffTheMap());

class OffTheMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExploreMapPage(),
    );
  }
}
