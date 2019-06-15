import 'package:flutter/material.dart';
import 'package:off_the_map/map_page.dart';

void main() => runApp(OffTheMap());

class OffTheMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapPage(),
    );
  }
}


