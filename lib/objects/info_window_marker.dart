import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:off_the_map/controllers/current_place_controller.dart';
import 'package:off_the_map/models/place.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../constants.dart';

class InfoWindowVisibilityController extends ChangeNotifier {
  bool _infoWindowVisible = false;

  get infoWindowVisible => _infoWindowVisible;
  set infoWindowVisible(bool value) {
    _infoWindowVisible = value;
    notifyListeners();
  }

  void toggleVisibility() {
    _infoWindowVisible = !_infoWindowVisible;
    notifyListeners();
  }

  // since the map reloads all the time, something needs to keep track of the state of all the markers
  // we will assign each info window a UUID to look up their controller
  static Map<String, InfoWindowVisibilityController> controllers = {};

  InfoWindowVisibilityController(String placeName) {
    controllers.addAll({placeName: this});
  }
}

/// includes marker and infowindow
class InfoWindowMarker {
  // static List<InfoWindowMarker> infoWindowMarkers = [];

  /// all InfoWindowMarkers will be associated with a Place
  Place place;

  final LatLng infoWindowLatLng;

  /// widget that builds the infowindow
  final Widget infoWindow;

  /// trying to center infowindow
  // TODO: find a better way to do this exactly and make sure it works on different screen sizes
  static const offsetFromMarker = Offset(0.01, 0.002);

  InfoWindowVisibilityController infoWindowVisibilityController;

  /// callback on marker tap
  VoidCallback customTapCallback;

  InfoWindowMarker({this.infoWindow, this.place, this.customTapCallback})
      : infoWindowLatLng = getOffsetLatLng(place.latLng) {

    switch (InfoWindowVisibilityController.controllers[this.place.name]) {
      case null:
        infoWindowVisibilityController =
            InfoWindowVisibilityController(place.name);
        break;
      default:
        infoWindowVisibilityController =
            InfoWindowVisibilityController.controllers[this.place.name];
        break;
    }
  }

  /// returns latlng positioned above infowindow's parentLatLng
  static LatLng getOffsetLatLng(LatLng parentLatLng) {
    LatLng latLng = LatLng(0, 0);

    latLng.latitude = parentLatLng.latitude + offsetFromMarker.dx;
    latLng.longitude = parentLatLng.longitude + offsetFromMarker.dy;

    return latLng;
  }

  static void closeAllInfoWindows() {
    for (InfoWindowVisibilityController controller
        in InfoWindowVisibilityController.controllers.values) {
      controller.infoWindowVisible = false;
    }
  }

  /// TODO: explain how this works. Is *slightly* hacky, but very explainable
  Marker getInfoWindowMarker() {
    return Marker(
      width:
          400.0, // arbitrarily large so that any given infowindow can fully show up
      height: 400.0,
      anchorPos: AnchorPos.align(AnchorAlign.top),
      point: place.latLng,
      builder: (ctx) {
        return ChangeNotifierProvider<InfoWindowVisibilityController>.value(
          value: infoWindowVisibilityController,
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // this comes before us closing info windows, etc. because if customTapCallback
                  // does something that causes setState like opening the footer, then it closes the infowindows
                  if (customTapCallback != null) customTapCallback();

                  InfoWindowMarker.closeAllInfoWindows();

                  infoWindowVisibilityController.toggleVisibility();
                  var places = Provider.of<List<Place>>(ctx);

                  CurrentPlaceController.currentPlace = place;
                },
                child: Container(
                  child: Icon(
                    Icons.location_on,
                    size: 50.0,
                    color: kOrangeMarkerColor,
                  ),
                ),
              ),

              // info window will end up above the icon due to the enclosing column's vertical direction
              Flexible(
                child: Consumer<InfoWindowVisibilityController>(
                  builder: (BuildContext context,
                      InfoWindowVisibilityController
                          infoWindowVisibilityController,
                      Widget child) {

                    return Visibility(
                      visible: infoWindowVisibilityController.infoWindowVisible,
                      child: infoWindow,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
