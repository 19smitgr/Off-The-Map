import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:off_the_map/objects/named_reference.dart';
import 'package:off_the_map/objects/named_reference_list.dart';

/// a `Place` is the information about a user-defined geographic place
class Place {
  String name = '';
  LatLng latLng;
  List<NamedReferenceList> topics = [];

  /// so we can search for child stories based on if they have this parent path
  DocumentReference reference;

  Place({@required this.name, @required this.latLng});

  Place.fromFirestore(DocumentSnapshot doc) {
    this.name = doc['name'];

    GeoPoint point = doc['point']['geopoint'];
    this.latLng = LatLng(point.latitude, point.longitude);

    this.reference = doc.reference;

    for (var map in doc['topics']) {
      this.topics.add(
            NamedReferenceList(
              name: map['name'],
              referenceList: map['stories'].cast<DocumentReference>(),
            ),
          );
    }
  }

  static Future<List<Place>> getPlacesFromFirestore() async {
    List<Place> places = [];

    Firestore.instance
        .collection('places')
        .getDocuments()
        .then((QuerySnapshot qs) {
      qs.documents.forEach((DocumentSnapshot document) {
        Place place = Place.fromFirestore(document);

        places.add(place);
      });
    });

    return places;
  }

  Stream<QuerySnapshot> getStories() {
    return Firestore.instance
        .collection('stories')
        .where('parentPlaceRef', isEqualTo: this.reference)
        .snapshots();
  }
}
