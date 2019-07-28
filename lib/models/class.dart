import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:off_the_map/objects/named_reference.dart';

class Class {
  String name = '';
  String code = '';
  List<NamedReference> users = [];

  DocumentReference reference;

  Class.fromFirestore(DocumentSnapshot doc) {
    this.name = doc['name'];
    this.code = doc['code'];

    if (doc['users'] != null) {
      for (var map in doc['users']) {
        var userRef =
            NamedReference(name: map['name'], reference: map['reference']);
        users.add(userRef);
      }
    }

    this.reference = doc.reference;
  }
}
