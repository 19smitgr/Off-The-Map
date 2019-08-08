import 'package:latlong/latlong.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/models/story.dart';

/// keeps track of current place in focus and the stories that the current place has
class CurrentPlaceController {
  static Place currentPlace;

  /// Map of Topic, List<Story> for currentPlace
  /// useful for searching through a given topic
  static Map<String, List<Story>> storiesByTopic = {};

  CurrentPlaceController({Place currentPlace}) {
    if (currentPlace == null) {
      currentPlace = Place(name: 'Default', latLng: LatLng(0,0));
    } else {
      CurrentPlaceController.currentPlace = currentPlace;
    }
  }

  /// Right now, just returns first element in story list
  /// TODO: return story with highest number of "likes"
  static Story getTopStoryForTopic(String topic) {
    return CurrentPlaceController.storiesByTopic[topic][0];
  }
}