import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:off_the_map/partials/info_window_marker.dart';
import 'package:off_the_map/partials/story.dart';
import 'package:off_the_map/student_view_map_page.dart';
import 'package:provider/provider.dart';

class MapArea extends StatefulWidget {
  /// when a marker on the map is tapped, this is what will popup above the marker
  final InstructionsCarouselFactory infoWindowFactory;

  MapArea({@required this.infoWindowFactory});

  @override
  _MapAreaState createState() => _MapAreaState();
}

class _MapAreaState extends State<MapArea> {
  @override
  Widget build(BuildContext context) {
    var stories = Provider.of<List<Story>>(context);

    List<InfoWindowMarker> infoWindowMarkers = [];

    for (Story story in stories) {
      var infoWindowMarker = InfoWindowMarker(
        infoWindow: widget.infoWindowFactory.generateInfoWindowTemplate(story: story),
        story: story
      );

      infoWindowMarkers.add(infoWindowMarker);
      InfoWindowMarker.infoWindowMarkers.add(infoWindowMarker);
    }

    return FlutterMap(
      options: MapOptions(
        center: LatLng(35.758584, -83.972536),
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
