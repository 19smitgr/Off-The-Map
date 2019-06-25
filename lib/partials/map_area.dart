import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../constants.dart';

class MapArea extends StatefulWidget {
  const MapArea({
    Key key,
  }) : super(key: key);

  @override
  _MapAreaState createState() => _MapAreaState();
}

class _MapAreaState extends State<MapArea> {
  InfoWindow infoWindow = InfoWindow(parentLatLng: LatLng(51.5, -0.09));

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate:
              'https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoiMTlzbWl0Z3IiLCJhIjoiY2p3anAxYnBhMHVhcTQ5bXhqOXczMTF4NSJ9.BpUH44ClryfRjH7ivHuL5Q',
            'id': 'mapbox.streets',
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              point: infoWindow.getOffsetLatLng(),
              builder: (context) {
                return InfoWindow(parentLatLng: LatLng(51.5, -0.09));
              },
              // TODO: figure out a way to make this fit the child content.
              // potentially after InfoWindow builds, it could pass size data back to parent
              width: 200,
              height: 165,
            ),
            Marker(
              point: LatLng(51.5, -0.09),
              builder: (ctx) => Container(
                    child: Icon(
                      Icons.location_on,
                      size: 50.0,
                      color: kOrangeMarkerColor,
                    ),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class InfoWindow extends StatefulWidget {
  // trying to center infowindow
  // TODO: find a better way to do this exactly and make sure it works on different screen sizes
  static const offsetFromMarker = Offset(0.01, 0.002);

  List<String> buttonCaptionsByPage = ['See Instructions', 'Close'];

  final LatLng parentLatLng;

  InfoWindow({this.parentLatLng});

  /// returns latlng positioned above infowindow's parentLatLng
  LatLng getOffsetLatLng() {
    LatLng latLng = LatLng(0, 0);

    latLng.latitude = parentLatLng.latitude + InfoWindow.offsetFromMarker.dx;
    latLng.longitude = parentLatLng.longitude + InfoWindow.offsetFromMarker.dy;

    return latLng;
  }

  @override
  _InfoWindowState createState() => _InfoWindowState();
}

class _InfoWindowState extends State<InfoWindow> {
  int _pageNum = 1;

  var slider = CarouselSlider(
    viewportFraction: 1.0,
    items: <Widget>[
      Text('1. Springbrook Park'),
      InstructionsScreen(),
    ],
  );

  /// This keeps track of page number by changing _pageNum
  void incrementPage() {
    int maxPageNum = widget.buttonCaptionsByPage.length;
    _pageNum == maxPageNum ? _pageNum = 1 : _pageNum++;
  }

  @override
  Widget build(BuildContext context) {
    String screenChangeBtnCaption = widget.buttonCaptionsByPage[_pageNum - 1];

    return Container(
      padding: EdgeInsets.all(5.0),
      color: kOrangeMarkerColor,
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: <Widget>[
            slider,
            RaisedButton(
              onPressed: () {
                incrementPage();

                slider.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );

                // rebuilds widget because _pageNum changed
                setState(() {});
              },
              child: Text(screenChangeBtnCaption),
            ),
          ],
        ),
      ),
    );
  }
}

class InstructionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Text('Instructions', style: kBoldText),
        SizedBox(height: 5.0),
        Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ac lacus ac risus molestie blandit. Phasellus dignissim, magna efficitur auctor mollis, est metus ultricies elit, ac ullamcorper turpis felis interdum ex. Nam in nulla nibh. Cras id sodales arcu. Quisque viverra mauris enim, vel feugiat erat eleifend in. Mauris vel dui tortor. Ut feugiat, est ut laoreet fermentum, elit quam tristique tellus, sit amet interdum orci neque ac neque.'),
      ],
    ));
  }
}

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
        print('working');
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
