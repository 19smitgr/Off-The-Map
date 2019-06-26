import 'package:flutter/material.dart';

import '../constants.dart';
import 'media_upload_button.dart';

class TitleYearInputScreen extends StatefulWidget {
  @override
  _TitleYearInputScreenState createState() => _TitleYearInputScreenState();
}

class _TitleYearInputScreenState extends State<TitleYearInputScreen> {
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
              Row(
                children: <Widget>[
                  Flexible(child: TextField()),
                  Text('Save'),
                ],
              ),
              SizedBox(height: 15.0),
              Text('What year(s) does your research come from?'),
              Row(
                children: <Widget>[
                  Flexible(child: TextField()),
                  Text('Add'),
                ],
              ),
              SizedBox(height: 15.0),
              Text('Add Media:'),
              Row(
                children: <Widget>[
                  Expanded(child: Center(child: MediaUploadButton(Icons.chat, 'Text'))),
                  Expanded(child: Center(child: MediaUploadButton(Icons.image, 'Image'))),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}