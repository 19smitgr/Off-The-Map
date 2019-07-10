import 'package:flutter/material.dart';
import 'package:off_the_map/partials/story.dart';

/// used to provide a template to a MapArea
/// MapArea will plug in a Story to a `InfoWindowTemplate`
/// And then the InfoWindowTemplate will generate a widget
abstract class InfoWindowTemplate {
  Widget generateInfoWindowTemplate({@required Story story});
}