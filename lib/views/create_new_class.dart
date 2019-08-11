import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/models/user.dart';

/// the page for a teacher to create a new class
class CreateNewClassPage extends StatefulWidget {
  final User user;

  CreateNewClassPage({@required this.user});

  @override
  _CreateNewClassPageState createState() => _CreateNewClassPageState();
}

class _CreateNewClassPageState extends State<CreateNewClassPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  bool hasError = false;
  String errorMessage = '';

  bool submitting = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrayBackgroundColor,
      appBar: AppBar(
        backgroundColor: kDarkBlueBackground,
        title: Text('Create Class'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: submitting,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                    'Your class name is the name you will see in your teacher dashboard. Create one below.'),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Give your class a name',
                  ),
                  validator: (String text) {
                    if (text.length == 0) {
                      return 'Name is required';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                    'Type anything at least 5 characters long that will serve as the key for students to join your class.'),
                TextFormField(
                  controller: codeController,
                  decoration: InputDecoration(
                    labelText: 'Class Code',
                    hintText: 'Give your class a code',
                  ),
                  validator: (String text) {
                    if (text.length <= 5) {
                      return 'Code cannot be less than 5 characters';
                    }

                    return null;
                  },
                ),
                if (hasError)
                  Text(
                    errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                RaisedButton(
                  color: kPurple,
                  onPressed: () async {
                    setState(() {
                      submitting = true;
                    });

                    if (_formKey.currentState.validate()) {
                      try {
                        QuerySnapshot querySnapshot = await Firestore.instance
                            .collection('classes')
                            .where('code', isEqualTo: codeController.text)
                            .getDocuments();
                        bool codeIsUnique = querySnapshot.documents.length == 0;

                        if (codeIsUnique) {
                          DocumentReference classRef = await Firestore.instance
                              .collection('classes')
                              .add({
                            'name': nameController.text,
                            'code': codeController.text,
                          });

                          List<Map<String, dynamic>> newCreatedClass = [
                            {'name': nameController.text, 'reference': classRef}
                          ];

                          widget.user.reference.updateData({
                            'createdClasses':
                                FieldValue.arrayUnion(newCreatedClass)
                          });

                          Navigator.pop(context);
                        } else {
                          setState(() {
                            hasError = true;
                            errorMessage =
                                'This code already exists. Please try another.';
                          });
                        }
                      } catch (e) {
                        setState(() {
                          hasError = true;
                          errorMessage = e;
                        });
                      }
                    }

                    setState(() {
                      submitting = false;
                    });
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
