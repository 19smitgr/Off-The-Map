import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlaceInstructionPair {
  DocumentReference placeRef;
  String instructions;

  PlaceInstructionPair({@required this.placeRef, @required this.instructions});

  Map<String, dynamic> toJson() {
    return {
      'instructions': this.instructions,
      'place': this.placeRef
    };
  }
}
