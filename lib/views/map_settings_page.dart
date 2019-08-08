import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';

class MapSettingsPage extends StatefulWidget {
  @override
  _MapSettingsPageState createState() => _MapSettingsPageState();
}

class _MapSettingsPageState extends State<MapSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Near You'),
        backgroundColor: kDarkBlueBackground,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Text('Current Map: General'),
            RaisedButton(
              color: kPurple,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MapChooserPage();
                    },
                  ),
                );
              },
              child: Text(
                'Change Map',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapChooserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Near You'),
        backgroundColor: kDarkBlueBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            RaisedButton(
              color: kPurple,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'General Map',
                style: TextStyle(color: Colors.white),
              ),
            ),
            RaisedButton(
              color: kPurple,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Maryville Historical',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
