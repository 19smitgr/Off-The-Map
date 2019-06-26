import 'package:flutter/material.dart';
import 'package:off_the_map/partials/text_editor.dart';

import '../constants.dart';

class MediaUploadButton extends StatefulWidget {
  final IconData iconData;
  final String caption;

  MediaUploadButton(this.iconData, this.caption);

  @override
  _MediaUploadButtonState createState() => _MediaUploadButtonState();
}

class _MediaUploadButtonState extends State<MediaUploadButton> {
  bool mediaHasBeenSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TextEditor()));
      },
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(widget.iconData),
              Text(widget.caption),
            ],
          ),
          if (mediaHasBeenSubmitted)
            Text('View Submitted', style: kAssignmentOptionStyle),
        ],
      ),
    );
  }
}