import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:off_the_map/models/place_instruction_pair.dart';
import 'package:off_the_map/objects/named_reference.dart';

class Assignment {
  String name = '';

  /// name of class and reference to class
  List<NamedReference> classesAssignedTo = [];

  List<PlaceInstructionPair> placesToResearch = [];
  String generalInstructions = '';

  /// to lookup assignments by owner
  DocumentReference ownerReference;

  /// allows us to access/modify later
  DocumentReference reference;

  Assignment.fromFirestore(DocumentSnapshot doc) {
    this.name = doc['name'];

    for (var map in doc['classesAssignedTo']) {
      var classRef =
          NamedReference(name: map['name'], reference: map['reference']);
      this.classesAssignedTo.add(classRef);
    }

    this.reference = doc.reference;

    for (var map in doc['placesToResearch']) {
      placesToResearch.add(
        PlaceInstructionPair(
          instructions: map['instructions'],
          placeRef: map['place'],
        ),
      );
    }

    this.ownerReference = doc['ownerReference'];
  }
}