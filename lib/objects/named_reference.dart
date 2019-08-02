import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// used to give detail about a reference without getting the whole referenced object
class NamedReference {
  String name;
  DocumentReference reference;

  NamedReference({@required this.name, @required this.reference});

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'reference': this.reference
    };
  }
} 
