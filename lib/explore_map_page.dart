import 'package:flutter/material.dart';
import 'package:off_the_map/partials/info_footer.dart';
import 'package:off_the_map/partials/map_area.dart';

class ExploreMapPage extends StatefulWidget {
  @override
  _ExploreMapPageState createState() => _ExploreMapPageState();
}

class _ExploreMapPageState extends State<ExploreMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration.collapsed(hintText: 'Search Places'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: MapArea(),
            ),
            Expanded(
              child: InfoFooter(
                child: Column(
                  children: <Widget>[],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
