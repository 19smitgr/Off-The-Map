import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

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
  DateTime dateWritten = DateTime.now();

  /// We have this in both Place and Story because it connects the two conceptually
  String topic;

  /// this will enable us to load the place from a story if we don't already have it loaded
  DocumentReference placeDocRef;


  Story({this.researchYears = const [], this.text = '', this.dateWritten, this.topic}) {
    dateWritten = DateTime.now();
  }

  Story.fromFirestore(data) {
    this.dateWritten = data['dateWritten'].toDate();
    this.researchYears = data['researchYears'].cast<int>();
    this.text = data['text'];
    this.topic = data['topic'];
  }
}

/// a `Place` is the information about a user-defined geographic place
///
/// **Example**:
/// ```dart
/// Place(
///   topicTitle: 'Origins',
///   topics: [StoryID(42f24f), ],
/// )
/// ```
class Place {
  String name;
  LatLng latLng;

  /// so we can search for child stories based on if they have this parent path
  DocumentReference path;

  Place({@required this.name, @required this.latLng});

  Place.fromFirestore(Map<String, dynamic> data, this.path) {
    this.name = data['name'];

    GeoPoint point = data['point']['geopoint'];
    this.latLng = LatLng(point.latitude, point.longitude);
  }

  static Future<List<Place>> getPlacesFromFirestore() async {
    List<Place> places = [];

    Firestore.instance
      .collection('places')
      .getDocuments()
      .then((QuerySnapshot qs) {
      qs.documents.forEach((DocumentSnapshot document) {
        Place place = Place.fromFirestore(document.data, document.reference);

        places.add(place);
      });
    });

    return places;
  }

  Stream<QuerySnapshot> getStories() {
    return Firestore.instance
      .collection('stories')
      .where('parentPlaceRef', isEqualTo: this.path)
      .snapshots();
  }
}