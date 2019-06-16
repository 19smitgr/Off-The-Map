import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../constants.dart';

class MapArea extends StatefulWidget {
  const MapArea({
    Key key,
  }) : super(key: key);

  @override
  _MapAreaState createState() => _MapAreaState();
}

class _MapAreaState extends State<MapArea> {
  bool showInfoWindow = false;
  InfoWindow infoWindow = InfoWindow(parentLatLng: LatLng(51.5, -0.09));

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlutterMap(
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
                width: 200,
                height: 150
              ),
              if (!showInfoWindow)
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
      ),
    );
  }
}

class InfoWindow extends StatefulWidget {
  // trying to center infowindow
  // TODO: find a better way to do this exactly and make sure it works on different screen sizes
  static const offsetFromMarker = Offset(0.01, 0.002);

  final LatLng parentLatLng;

  InfoWindow({this.parentLatLng});

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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kOrangeMarkerColor,
    );
  }
}
