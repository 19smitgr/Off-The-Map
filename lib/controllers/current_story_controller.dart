import 'package:flutter/widgets.dart';
import 'package:off_the_map/models/story.dart';

/// keeps track of the current story in focus for a page
class CurrentStoryController extends ChangeNotifier {
  Story _currentStory;

  CurrentStoryController() {
    currentStory = Story();
  }

  /// note: notifies listeners of changes 
  set currentStory(Story story) {
    _currentStory = story;
    notifyListeners();
  }

  get currentStory => _currentStory;
}