import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/controllers/current_place_controller.dart';
import 'package:off_the_map/models/story.dart';
import 'package:off_the_map/views/partials/place_story.dart';
import 'package:off_the_map/views/partials/text_editor.dart';

class PlaceStoryPage extends StatelessWidget {
  final String topic;
  final List<Story> stories;
  final CurrentPlaceController currentPlaceController;

  PlaceStoryPage({this.topic, this.stories, this.currentPlaceController});

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: kGrayBackgroundColor,
      appBar: AppBar(
        title: Text(currentPlaceController.currentPlace.name, style: kHeader),
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
              child: Text(topic, style: kHeader),
            ),
            Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: <Widget>[
                      for (Story story in stories)
                        PlaceStory(
                      story: story,
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              print("something");
                            },
                            icon: Icon(Icons.location_on)),
                        SizedBox(
                          width: 5.0,
                        ),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.thumb_up)),
                        SizedBox(
                          width: 5.0,
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.chat)),
                      ],
                    ),
                    ],),
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
                        'All College Hill Park Topics',
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
