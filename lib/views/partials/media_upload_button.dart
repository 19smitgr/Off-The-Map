import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/controllers/media_upload_button_controller.dart';

typedef Widget BuildMediaView(BuildContext context);

class MediaUploadButton extends StatelessWidget {
  final IconData iconData;
  final String caption;
  final BuildMediaView buildMediaView;
  final MediaUploadButtonController mediaUploadButtonController = MediaUploadButtonController();

  MediaUploadButton(this.iconData, this.caption, this.buildMediaView);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: buildMediaView));
      },
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(iconData),
              Text(caption),
            ],
          ),
          if (mediaUploadButtonController.mediaHasBeenSubmitted)
            Text('View Submitted', style: kAssignmentOptionStyle),
        ],
      ),
    );
  }
}