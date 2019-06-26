import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:off_the_map/partials/infowindow.dart';

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