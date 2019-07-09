import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';

class PlaceStory extends StatefulWidget {
  @override
  _PlaceStoryState createState() => _PlaceStoryState();
}

class _PlaceStoryState extends State<PlaceStory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('Garrett Smith —', style: kBoldText),
            Text('June 26th'),
          ],
        ),
        Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod pretium dignissim. Vestibulum eu luctus augue. Sed convallis nibh ut turpis mollis, sed euismod dui porttitor. Vivamus faucibus orci turpis, egestas pellentesque sapien tempor nec. Ut neque nisi, commodo et lectus at, laoreet porta justo. Sed pharetra velit eu nibh tempor dapibus.'),
        Divider(),
        Row(
          children: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.location_on)),
            SizedBox(width: 5.0,),
            IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up)),
            SizedBox(width: 5.0,),
            IconButton(onPressed: () {}, icon: Icon(Icons.chat)),
          ],
        ),
      ],
    );
  }
}
