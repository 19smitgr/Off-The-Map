import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';

typedef Widget BuildMediaView(BuildContext context);

class MediaUploadButton extends StatefulWidget {
  final IconData iconData;
  final String caption;
  final BuildMediaView buildMediaView;

  MediaUploadButton(this.iconData, this.caption, this.buildMediaView);

  @override
  _MediaUploadButtonState createState() => _MediaUploadButtonState();
}

class _MediaUploadButtonState extends State<MediaUploadButton> {
  bool mediaHasBeenSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: widget.buildMediaView));
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