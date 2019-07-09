import 'package:flutter/material.dart';
import 'package:off_the_map/partials/text_editor.dart';
import 'package:off_the_map/place_story.dart';

import 'constants.dart';

class PlaceStoryPage extends StatefulWidget {
  @override
  _PlaceStoryPageState createState() => _PlaceStoryPageState();
}

class _PlaceStoryPageState extends State<PlaceStoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('College Hill Park', style: kHeader),
        backgroundColor: Color(0xFF93639A),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text('1960: Origins', style: kHeader),
            ),
            Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: PlaceStory(),
                  ),
                ),
                flex: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 4.0,
                    ),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Color(0xFF93639A), // purple
                      child: Text(
                        'All College Hill Park Stories',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 4.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TextEditor()));
                      },
                      color: Color(0xFF93639A), // purple
                      child: Text(
                        'Contribute to Topic',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
