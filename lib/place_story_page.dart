import 'package:flutter/material.dart';
import 'package:off_the_map/partials/text_editor.dart';

import 'constants.dart';

class PlaceStoryPage extends StatefulWidget {
  @override
  _PlaceStoryPageState createState() => _PlaceStoryPageState();
}

class _PlaceStoryPageState extends State<PlaceStoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('College Hill Park', style: kHeader),
        backgroundColor: Color(0xFF93639A),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text('1960: Origins', style: kHeader),
            ),
            Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: PlaceStory(),
                  ),
                ),
                flex: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 4.0),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Color(0xFF93639A), // purple
                      child: Text(
                        'All College Hill Park Stories',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 4.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TextEditor()));
                      },
                      color: Color(0xFF93639A), // purple
                      child: Text(
                        'Contribute to Topic',
                        style: TextStyle(color: Colors.white),
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
