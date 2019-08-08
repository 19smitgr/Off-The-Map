import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:off_the_map/models/assignment.dart';
import 'package:off_the_map/models/story.dart';

class UncompletedAssignment {
  DocumentReference assignmentReference;
  Assignment assignment;

  // map of place reference -> Story
  Map<DocumentReference, Story> places = {};
  String uid;

  UncompletedAssignment.fromAssignmentTemplate(Assignment assignment) {
    for (int i = 0; i < assignment.placesToResearch.length; i++) {
      places.addAll({assignment.placesToResearch[i].placeRef: Story()});
    }
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'assignmentRef': this.assignmentReference,
      'places': this.places.values,
      'uid': uid,
    };
  }
}