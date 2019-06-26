import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../footer_controller.dart';
import 'instruction_screen.dart';

class InfoWindow extends StatefulWidget {
  // trying to center infowindow
  // TODO: find a better way to do this exactly and make sure it works on different screen sizes
  static const offsetFromMarker = Offset(0.01, 0.002);

  final List<String> buttonCaptionsByPage = ['See Instructions', 'Close'];

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
      child: Column(
        children: <Widget>[
          slider,
          RaisedButton(
            onPressed: () {
              // toggle whether footer is visible
              FooterController footerController = Provider.of<FooterController>(context);
              footerController.extended = !footerController.extended;

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
    );
  }
}
