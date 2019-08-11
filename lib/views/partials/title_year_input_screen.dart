import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/controllers/current_place_controller.dart';
import 'package:off_the_map/controllers/footer_controller.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/models/story.dart';
import 'package:off_the_map/objects/info_window_marker.dart';
import 'package:off_the_map/views/partials/text_editor.dart';
import 'package:provider/provider.dart';

import 'media_upload_button.dart';

class TitleYearInputScreenController extends ChangeNotifier {
  bool editingTitle = true;
  bool editingCitation = true;
}

/// the form to input information about a new story.
class TitleYearInputScreen extends StatelessWidget {
  final TextEditingController researchYearsController =
      TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController citationController = TextEditingController();
  final TitleYearInputScreenController titleYearInputScreenController =
      TitleYearInputScreenController();

  final Story story;

  TitleYearInputScreen({@required this.story});

  @override
  Widget build(BuildContext context) {
    Place place = CurrentPlaceController.currentPlace;

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
                Wrap(
                  children: [
                    Text(
                      'Years Added: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      story.researchYears.join(', '),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                if (titleYearInputScreenController.editingCitation)
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          controller: citationController,
                          decoration: InputDecoration(
                            labelText: 'Cite any sources you used:',
                            hintText: 'Enter Citation',
                          ),
                        ),
                      ),
                      FlatButton(
                        child: Text('Save', style: kAssignmentOptionStyle),
                        onPressed: () {
                          story.citation = citationController.text;

                          if (citationController.text.length > 0) {
                            titleYearInputScreenController.editingTitle = false;
                          }
                        },
                      ),
                    ],
                  ),
                if (!titleYearInputScreenController.editingCitation)
                  Row(
                    children: <Widget>[
                      Text('Title: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text(
                          story.citation,
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      FlatButton(
                        child: Text('Edit', style: kAssignmentOptionStyle),
                        onPressed: () {
                          titleYearInputScreenController.editingCitation = true;
                          citationController.text = story.citation;
                        },
                      ),
                    ],
                  ),
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
                    var footerController =
                        Provider.of<FooterController>(context);
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
