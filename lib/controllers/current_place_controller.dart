import 'package:latlong/latlong.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/models/story.dart';

/// keeps track of current place in focus and the stories that the current place has
class CurrentPlaceController {
  Place currentPlace = Place(name: 'Default', latLng: LatLng(0,0));

  /// Map of Topic, List<Story> for currentPlace
  /// useful for searching through a given topic
  Map<String, List<Story>> storiesByTopic = {};

  CurrentPlaceController({this.currentPlace});

  /// Right now, just returns first element in story list
  /// TODO: return story with highest number of "likes"
  Story getTopStoryForTopic(String topic) {
    return this.storiesByTopic[topic][0];
  }
}