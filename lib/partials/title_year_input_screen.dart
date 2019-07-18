import 'package:flutter/material.dart';
import 'package:off_the_map/current_place_controller.dart';
import 'package:off_the_map/current_story_controller.dart';
import 'package:off_the_map/partials/info_window_marker.dart';
import 'package:off_the_map/partials/story.dart';
import 'package:off_the_map/partials/text_editor.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../footer_controller.dart';
import 'media_upload_button.dart';

class TitleYearInputScreen extends StatefulWidget {
  @override
  _TitleYearInputScreenState createState() => _TitleYearInputScreenState();
}

class _TitleYearInputScreenState extends State<TitleYearInputScreen> {
  TextEditingController researchYearsController = new TextEditingController();

  TextEditingController titleController = new TextEditingController();
  bool editingTitle = true;

  @override
  Widget build(BuildContext context) {
    var currentPlaceController = Provider.of<CurrentPlaceController>(context);
    Place place = currentPlaceController.currentPlace;

    var currentStoryController = Provider.of<CurrentStoryController>(context);
    Story story = currentStoryController.currentStory;

    return Column(
      children: <Widget>[
        Text(story.topic, style: kHeader),
        SizedBox(height: 15.0),
        Flexible(
          child: ListView(
            children: <Widget>[
              Text('Title your findings'),
              if (editingTitle)
                Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: titleController,
                      ),
                    ),
                    FlatButton(
                      child: Text('Save', style: kAssignmentOptionStyle),
                      onPressed: () {
                        story.topic = titleController.text;

                        if (story.topic.length > 0) {
                          editingTitle = false;
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
              if (!editingTitle)
                Row(
                  children: <Widget>[
                    Text('Title: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        story.topic,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    FlatButton(
                      child: Text('Edit', style: kAssignmentOptionStyle),
                      onPressed: () {
                        editingTitle = true;
                        titleController.text = story.topic;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              SizedBox(height: 15.0),
              Text('What year(s) does your research come from?'),
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: researchYearsController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  FlatButton(
                    child: Text('Add', style: kAssignmentOptionStyle),
                    onPressed: () {
                      int year = int.parse(researchYearsController.text);

                      if (year != null) {
                        story.researchYears.add(year);

                        researchYearsController.text = '';
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
              Wrap(children: [
                Text(
                  'Years Added: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(story.researchYears.join(', '))
              ]),
              SizedBox(height: 15.0),
              Text('Add Media:'),
              Row(
                children: <Widget>[
                  MediaUploadButton(
                    Icons.chat,
                    'Text',
                    (context) => TextEditor(),
                  ),
                ],
              ),
              RaisedButton(
                color: Color(0xFF93639A),
                onPressed: () {
                  // toggle whether footer is visible
                  var footerController = Provider.of<FooterController>(context);
                  footerController.extended = !footerController.extended;

                  InfoWindowMarker.closeAllInfoWindows();
                },
                child: Text(
                  'SAVE AND CLOSE',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
