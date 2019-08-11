import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:off_the_map/constants.dart';
import 'package:provider/provider.dart';
import 'package:zefyr/zefyr.dart';
import 'package:uuid/uuid.dart';

/// full screen editor; returns data on pop()
class TextEditor extends StatefulWidget {
  @override
  TextEditorState createState() => TextEditorState();
}

class TextEditorState extends State<TextEditor> {
  ZefyrController controller;
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    // Create an empty document or load existing if you have one.
    // Here we create an empty document:
    final document = NotusDocument();
    controller = ZefyrController(document);
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final theme = new ZefyrThemeData(
      cursorColor: Colors.blue,
      toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
        color: Colors.grey.shade800,
        toggleColor: Colors.grey.shade900,
        iconColor: Colors.white,
        disabledIconColor: Colors.grey.shade500,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        leading: Container(),
        elevation: 1.0,
        backgroundColor: kDarkBlueBackground,
        brightness: Brightness.light,
        title: Text('Decribe Your Findings'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context, json.encode(controller.document));
            },
            child: Text('DONE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: ZefyrScaffold(
        child: ZefyrTheme(
          data: theme,
          child: ZefyrEditor(
            controller: controller,
            focusNode: focusNode,
            imageDelegate: FirebaseStorageImageDelagate(context: context),
          ),
        ),
      ),
    );
  }
}

class FirebaseStorageImageDelagate extends ZefyrImageDelegate {
  BuildContext context;
  FirebaseStorage firebaseStorage;

  FirebaseStorageImageDelagate({this.context}) {
    // Provided from main()
    firebaseStorage = Provider.of<FirebaseStorage>(context);
  }

  @override
  Widget buildImage(BuildContext context, String imageSource) {
    print(imageSource);
    return Image.network(imageSource);
  }

  @override
  Future<String> pickImage(source) async {
    final File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return null;

    Uuid uniqueId = Uuid();
    
    // even though .ref() initializes at root, it crashes for some reason, 
    // so we have to explicitely call getRoot() again
    StorageReference ref = firebaseStorage.ref().child('images/${uniqueId.v4()}.png');

    StorageMetadata metadata = StorageMetadata(contentType: 'image/${path.extension(file.toString())}');

    StorageUploadTask storageUploadTask = ref.putFile(file, metadata);
    await storageUploadTask.onComplete;

    var url = await ref.getDownloadURL();
    print(url);
    return url;
  }
}
