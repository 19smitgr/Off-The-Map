import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapArea extends StatelessWidget {
  const MapArea({
    Key key,
  }) : super(key: key);

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
            urlTemplate: 'https://a.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoiMTlzbWl0Z3IiLCJhIjoiY2p3anAxYnBhMHVhcTQ5bXhqOXczMTF4NSJ9.BpUH44ClryfRjH7ivHuL5Q',
              'id': 'mapbox.streets',
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(51.5, -0.09),
                builder: (ctx) => Container(
                      child: FlutterLogo(),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}