import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/controllers/current_place_controller.dart';
import 'package:off_the_map/controllers/current_story_controller.dart';
import 'package:off_the_map/controllers/footer_controller.dart';
import 'package:off_the_map/controllers/title_year_input_screen_controller.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/models/story.dart';
import 'package:off_the_map/objects/info_window_marker.dart';
import 'package:off_the_map/views/partials/text_editor.dart';
import 'package:provider/provider.dart';

import 'media_upload_button.dart';

class TitleYearInputScreen extends StatelessWidget {
  final TextEditingController researchYearsController = new TextEditingController();
  final TextEditingController titleController = new TextEditingController();
  final TitleYearInputScreenController titleYearInputScreenController = TitleYearInputScreenController();

  @override
  Widget build(BuildContext context) {
    var currentPlaceController = Provider.of<CurrentPlaceController>(context);
    Place place = currentPlaceController.currentPlace;

    var currentStoryController = Provider.of<CurrentStoryController>(context);
    Story story = currentStoryController.currentStory;

    return Column(
      children: <Widget>[
        Text(place.name, style: kHeader),
        SizedBox(height: 15.0),
        Flexible(
          child: ChangeNotifierProvider<TitleYearInputScreenController>.value(
            value: titleYearInputScreenController,
                      child: ListView(
              children: <Widget>[
                Text('Title your findings'),
                if (titleYearInputScreenController.editingTitle)
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
                            titleYearInputScreenController.editingTitle = false;
                          }
                        },
                      ),
                    ],
                  ),
                if (!titleYearInputScreenController.editingTitle)
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
                          titleYearInputScreenController.editingTitle = true;
                          titleController.text = story.topic;
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
          ),
        )
      ],
    );
  }
}
