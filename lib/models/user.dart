import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:off_the_map/objects/named_reference.dart';
import 'package:off_the_map/objects/named_reference_list.dart';

class User {
  String name = '';

  /// connects the user to the firebase auth
  String uid = '';

  /// direction reference within database
  DocumentReference reference;

  List<NamedReference> createdClasses = [];
  List<NamedReference> joinedClasses = [];
  List<NamedReference> assignmentBank = [];
  List<NamedReference> createdStories = [];
  List<NamedReferenceList> completedAssignments = [];

  User({this.name});

  User.fromFirestore(DocumentSnapshot doc) {
    this.name = doc['name'];
    this.uid = doc['uid'];
    this.reference = doc.reference;

    for (var schoolClass in doc['createdClasses']) {
      this.createdClasses.add(
            NamedReference(
              name: schoolClass['name'],
              reference: schoolClass['reference'],
            ),
          );
    }
    for (var schoolClass in doc['joinedClasses']) {
      this.joinedClasses.add(
            NamedReference(
              name: schoolClass['name'],
              reference: schoolClass['reference'],
            ),
          );
    }

    for (var assignment in doc['assignmentBank']) {
      var assignmentRef = NamedReference(
        name: assignment['name'],
        reference: assignment['reference'],
      );
      assignmentBank.add(assignmentRef);
    }

    for (var map in doc['completedAssignments']) {
      var assignmentRef = NamedReferenceList(
        name: map['name'],
        referenceList: map['places'].cast<DocumentReference>(),
      );
      completedAssignments.add(assignmentRef);
    }

    for (var map in doc['createdStories']) {
      var storyRef = NamedReference(
        name: map['name'],
        reference: map['reference'],
      );
      createdStories.add(storyRef);
    }
  }
}
