import 'package:flutter/widgets.dart';
import 'package:off_the_map/models/story.dart';

class CurrentStoryController extends ChangeNotifier {
  Story _currentStory;

  CurrentStoryController() {
    currentStory = Story();
  }

  set currentStory(Story story) {
    _currentStory = story;
    notifyListeners();
  }

  get currentStory => _currentStory;
}