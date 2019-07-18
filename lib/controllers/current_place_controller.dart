import 'package:latlong/latlong.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/models/story.dart';

class CurrentPlaceController {
  Place currentPlace;

  /// Map of Topic, List<Story> for currentPlace
  /// useful for searching through a given topic
  Map<String, List<Story>> storiesByTopic = {};

  CurrentPlaceController() {
    currentPlace = Place(name: '', latLng: LatLng(0,0));
  }

  Story getTopStoryForTopic(String topic) {
    return this.storiesByTopic[topic][0];
  }
}