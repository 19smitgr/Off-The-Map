import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/objects/info_window_marker.dart';
import 'package:off_the_map/objects/info_window_template_widget.dart';
import 'package:provider/provider.dart';

class MapArea extends StatefulWidget {
  /// when a marker on the map is tapped, this is what will popup above the marker
  final InfoWindowTemplate infoWindowFactory;

  /// callback for when the marker associated with the info window is tapped
  final VoidCallback markerCustomTapCallback;

  MapArea({@required this.infoWindowFactory, this.markerCustomTapCallback});

  @override
  _MapAreaState createState() => _MapAreaState();
}

class _MapAreaState extends State<MapArea> {
  @override
  Widget build(BuildContext context) {
    var places = Provider.of<List<Place>>(context);

    List<InfoWindowMarker> infoWindowMarkers = [];
    InfoWindowMarker infoWindowMarker;

    for (Place place in places) {
      if (widget.markerCustomTapCallback == null) {
        infoWindowMarker = InfoWindowMarker(
            infoWindow: widget.infoWindowFactory
                .generateInfoWindowTemplate(place: place),
            place: place);
      } else {
        infoWindowMarker = InfoWindowMarker(
            infoWindow: widget.infoWindowFactory
                .generateInfoWindowTemplate(place: place),
            place: place,
            customTapCallback: widget.markerCustomTapCallback);
      }

      infoWindowMarkers.add(infoWindowMarker);
      InfoWindowMarker.infoWindowMarkers.add(infoWindowMarker);
    }

    return FlutterMap(
      options: MapOptions(
        center: LatLng(35.754584, -83.974536),
        zoom: 16.0,
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
              ...infoWindowMarker.getInfoWindowMarker(),
          ],
        ),
      ],
    );
  }
}
