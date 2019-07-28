import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NamedReferenceList {
  dynamic name;
  List<DocumentReference> referenceList;

  NamedReferenceList({@required this.name, @required this.referenceList});
}