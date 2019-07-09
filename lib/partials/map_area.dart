import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:off_the_map/partials/info_window_marker.dart';
import 'package:off_the_map/partials/story.dart';
import 'package:off_the_map/student_view_map_page.dart';

class MapArea extends StatefulWidget {
  /// when a marker on the map is tapped, this is what will popup above the marker
  final InstructionsCarouselFactory infoWindowFactory;

  MapArea({@required this.infoWindowFactory});

  @override
  _MapAreaState createState() => _MapAreaState();
}

class _MapAreaState extends State<MapArea> {
  List<Story> stories = [
    Story(title: 'College Hill Park', latLng: LatLng(35.758584, -83.972536)),
    Story(title: 'Maryville College', latLng: LatLng(35.759, -83.972536)),
    Story(title: 'Municipal Building', latLng: LatLng(35.758584, -83.973)),
    Story(title: 'House Cafe', latLng: LatLng(35.759, -83.973))
  ];

  @override
  Widget build(BuildContext context) {
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
            for (Story story in stories)
              ...InfoWindowMarker(
                infoWindow: widget.infoWindowFactory
                    .generateInstructionsCarousel(title: story.title),
                latLng: story.latLng,
              ).getInfoWindowMarker(),
          ],
        ),
      ],
    );
  }
}
