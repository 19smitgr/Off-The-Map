import 'package:flutter/material.dart';

import '../constants.dart';
import 'media_upload_button.dart';

class TitleYearInputScreen extends StatefulWidget {
  @override
  _TitleYearInputScreenState createState() => _TitleYearInputScreenState();
}

class _TitleYearInputScreenState extends State<TitleYearInputScreen> {
  TextEditingController researchYearsController = new TextEditingController();
  List<String> researchYears = [];

  TextEditingController titleController = new TextEditingController();
  String title = '';
  bool editingTitle = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('College Hill Park', style: kHeader),
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
                        title = titleController.text;

                        if (title.length > 0) {
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
                        child: Text(title,
                            style: TextStyle(fontStyle: FontStyle.italic))),
                    FlatButton(
                      child: Text('Edit', style: kAssignmentOptionStyle),
                      onPressed: () {
                        editingTitle = true;
                        titleController.text = title;
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
                    ),
                  ),
                  FlatButton(
                    child: Text('Add', style: kAssignmentOptionStyle),
                    onPressed: () {
                      String year = researchYearsController.text;

                      if (year.length > 0) {
                        researchYears.add(year);
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
                Text(researchYears.join(', '))
              ]),
              SizedBox(height: 15.0),
              Text('Add Media:'),
              Row(
                children: <Widget>[
                  Expanded(
                    child: MediaUploadButton(Icons.chat, 'Text'),
                  ),
                  // Expanded(
                  //   child: Center(
                  //     child: MediaUploadButton(Icons.image, 'Image'),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
