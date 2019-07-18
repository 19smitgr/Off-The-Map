import 'package:off_the_map/models/place.dart';

/// controls the data for MapAreas or generally widgets with maps
class MapAreaController {
  // // dummy data
  // List<Place> places = [
  //   Place(name: 'College Hill Park', latLng: LatLng(35.748318, -83.970284)),
  //   Place(name: 'Maryville College', latLng: LatLng(35.751353, -83.964528)),
  //   Place(name: 'Municipal Building', latLng: LatLng(35.758584, -83.973)),
  //   Place(name: 'Vulcan Quarry', latLng: LatLng(35.732283, -83.957176))
  // ];

  /// keeps track of current places on a map
  List<Place> places = [];
}