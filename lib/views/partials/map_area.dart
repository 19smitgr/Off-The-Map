import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/objects/info_window_marker.dart';
import 'package:off_the_map/objects/info_window_template_widget.dart';
import 'package:provider/provider.dart';

typedef void AcceptsLatLng(LatLng latLng);

class MapAreaController {
  LatLng center = LatLng(35.754584, -83.974536);
  double zoom = 16.0;
  List<Place> places = [];
}

class MapArea extends StatelessWidget {
  /// when a marker on the map is tapped, this is what will popup above the marker
  final InfoWindowTemplate infoWindowFactory;

  final MapController mapController = MapController();
  final MapAreaController mapAreaController = MapAreaController();

  /// callback for when the marker associated with the info window is tapped
  final VoidCallback markerCustomTapCallback;
  final AcceptsLatLng mapTapCallback;

  static defaultMapTapCallback(LatLng latLng) {
    // this is kind of hacky, but I'm still not exactly sure how to provide an optional value
    // in the constructor for a final field.
  }

  MapArea(
      {@required this.infoWindowFactory,
      this.markerCustomTapCallback,
      this.mapTapCallback = defaultMapTapCallback});

  @override
  Widget build(BuildContext context) {
    var places = Provider.of<List<Place>>(context);

    List<InfoWindowMarker> infoWindowMarkers = [];
    InfoWindowMarker infoWindowMarker;

    for (Place place in places) {
      if (markerCustomTapCallback == null) {
        infoWindowMarker = InfoWindowMarker(
          infoWindow:
              infoWindowFactory.generateInfoWindowTemplate(place: place),
          place: place,
        );
      } else {
        infoWindowMarker = InfoWindowMarker(
          infoWindow:
              infoWindowFactory.generateInfoWindowTemplate(place: place),
          place: place,
          customTapCallback: markerCustomTapCallback,
        );
      }

      infoWindowMarkers.add(infoWindowMarker);
    }

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: mapAreaController.center,
        zoom: mapAreaController.zoom,
        onTap: (LatLng latLng) {
          print(mapController);

          // mapController.move(latLng, mapAreaController.zoom);
          mapAreaController.center = latLng;
          mapTapCallback(latLng);
        },
        onPositionChanged: (MapPosition pos, bool hasGesture, bool isUserGesture) {
          // mapAreaController.zoom = pos.zoom;
          // mapAreaController.center = pos.center;
        }
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
            // an infoWindowMarker consists of the infowindow and its anchor marker
            //this adds both to the marker list
            for (InfoWindowMarker infoWindowMarker in infoWindowMarkers)
              infoWindowMarker.getInfoWindowMarker(),
          ],
        ),
      ],
    );
  }
}
