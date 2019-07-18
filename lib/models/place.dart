import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

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