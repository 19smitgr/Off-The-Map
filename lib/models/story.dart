import 'package:cloud_firestore/cloud_firestore.dart';

/// An individual `Story` is one person's contribution to the information about a place.
/// This only currently includes text.
///
/// **Example**:
/// ```dart
/// Story(
///   researchYears: [1995, 1997, 2000],
///   text: 'College Hill Park was founded in 1995, amidst a year of turmoil...',
///   dateWritten: DateTime.now(), // 2019-07-11 09:13:13Z
/// )
/// ```
class Story {
  /// years that a person's research may discuss
  List<int> researchYears;
  String text;
  DateTime dateWritten;

  /// We have this in both Place and Story because it connects the two conceptually
  String topic;

  /// this will enable us to load the place from a story if we don't already have it loaded
  DocumentReference placeDocRef;

  Story({this.researchYears = const [], this.text = '', this.dateWritten, this.topic = ''}) {
    dateWritten = DateTime.now();
  }

  Story.fromFirestore(data) {
    this.dateWritten = data['dateWritten'].toDate();
    this.researchYears = data['researchYears'].cast<int>();
    this.text = data['text'];
    this.topic = data['topic'];
  }
}