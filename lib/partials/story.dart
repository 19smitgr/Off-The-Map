import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class Story {
  String title;
  List<int> researchYears;
  String text;
  DateTime dateWritten = DateTime.now();
  LatLng latLng;

  Story({this.title = '', this.researchYears = const [], this.text = '', this.dateWritten, this.latLng}) {
    dateWritten = DateTime.now();
  }
}