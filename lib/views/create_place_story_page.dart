import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/models/story.dart';
import 'package:off_the_map/views/create_assignment_page.dart';
import 'package:off_the_map/views/partials/media_upload_button.dart';
import 'package:off_the_map/views/partials/text_editor.dart';
import 'package:off_the_map/views/partials/title_year_input_screen.dart';
import 'package:provider/provider.dart';

class CreatePlaceStoryPage extends StatefulWidget {
  @override
  _CreatePlaceStoryPageState createState() => _CreatePlaceStoryPageState();
}

class _CreatePlaceStoryPageState extends State<CreatePlaceStoryPage> {
  // Create new story for the TitleYearInputScreen to fill out
  Story story = Story();
  Place place;
  TitleYearInputScreenController titleYearInputScreenController =
      TitleYearInputScreenController();
  final TextEditingController researchYearsController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController citationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrayBackgroundColor,
      appBar: AppBar(
        backgroundColor: kDarkBlueBackground,
        title: Text('Create'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              color: kPurple,
              onPressed: () async {
                Place place = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Scaffold(
                        body: PlaceSelectionPage(),
                      );
                    },
                  ),
                );
              },
              child: Text(
                'Choose Place',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(place?.name ?? 'No Place Chosen', style: kHeader),
                  SizedBox(height: 15.0),
                  Flexible(
                    child: ChangeNotifierProvider<
                        TitleYearInputScreenController>.value(
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
                                  child: Text('Save',
                                      style: kAssignmentOptionStyle),
                                  onPressed: () {
                                    setState(() {
                                      story.topic = titleController.text;

                                      if (story.topic.length > 0) {
                                        titleYearInputScreenController
                                            .editingTitle = false;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          if (!titleYearInputScreenController.editingTitle)
                            Row(
                              children: <Widget>[
                                Text('Title: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                  child: Text(
                                    story.topic,
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                FlatButton(
                                  child: Text('Edit',
                                      style: kAssignmentOptionStyle),
                                  onPressed: () {
                                    setState(() {
                                      titleYearInputScreenController
                                          .editingTitle = true;
                                      titleController.text = story.topic;
                                    });
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
                                child:
                                    Text('Add', style: kAssignmentOptionStyle),
                                onPressed: () {
                                  setState(() {
                                    int year =
                                        int.parse(researchYearsController.text);

                                    if (year != null) {
                                      story.researchYears.add(year);

                                      researchYearsController.text = '';
                                    }
                                  });
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
                                story.researchYears?.join(', ') ??
                                    'No Years Added',
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
                                  child: Text('Save',
                                      style: kAssignmentOptionStyle),
                                  onPressed: () {
                                    setState(() {
                                      story.citation = citationController.text;

                                      if (citationController.text.length > 0) {
                                        titleYearInputScreenController
                                            .editingCitation = false;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          if (!titleYearInputScreenController.editingCitation)
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    story.citation,
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                FlatButton(
                                  child: Text('Edit',
                                      style: kAssignmentOptionStyle),
                                  onPressed: () {
                                    setState(() {
                                      titleYearInputScreenController
                                          .editingCitation = true;
                                      citationController.text = story.citation;
                                    });
                                  },
                                ),
                              ],
                            ),
                          SizedBox(height: 15.0),
                          Text('Add Media:'),
                          Row(
                            children: <Widget>[
                              FlatButton(
                                onPressed: () async {
                                  story.text = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return TextEditor();
                                      },
                                    ),
                                  );
                                },
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.chat),
                                        Text('Text'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: RaisedButton(
                              color: kPurple,
                              onPressed: () {},
                              child: Text('Submit',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
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
