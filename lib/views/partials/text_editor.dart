import 'package:flutter/material.dart';
// import 'package:zefyr/zefyr.dart';

class TextEditor extends StatefulWidget {
  @override
  TextEditorState createState() => TextEditorState();
}

class TextEditorState extends State<TextEditor> {
  // ZefyrController _controller;
  // FocusNode _focusNode;

  // @override
  // void initState() {
  //   super.initState();
  //   // Create an empty document or load existing if you have one.
  //   // Here we create an empty document:
  //   final document = new NotusDocument();
  //   _controller = new ZefyrController(document);
  //   _focusNode = new FocusNode();
  // }

  @override
  Widget build(BuildContext context) {
    // final theme = new ZefyrThemeData(
    //   cursorColor: Colors.blue,
    //   toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
    //     color: Colors.grey.shade800,
    //     toggleColor: Colors.grey.shade900,
    //     iconColor: Colors.white,
    //     disabledIconColor: Colors.grey.shade500,
    //   ),
    // );

    // return Scaffold(
    //   resizeToAvoidBottomPadding: true,
    //   appBar: AppBar(
    //     leading: Container(),
    //     elevation: 1.0,
    //     backgroundColor: kDarkBlueBackground,
    //     brightness: Brightness.light,
    //     title: Text('Decribe Your Findings'),
    //     actions: [
    //       FlatButton(
    //         onPressed: () {
    //           print(json.encode(_controller.document));

              

    //           Navigator.pop(context);
    //         },
    //         child: Text('DONE', style: TextStyle(color: Colors.white)),
    //       ),
    //     ],
    //   ),
    //   body: ZefyrScaffold(
    //     child: ZefyrTheme(
    //       data: theme,
    //       child: ZefyrEditor(
    //         controller: _controller,
    //         focusNode: _focusNode,
    //         imageDelegate: ZefyrDefaultImageDelegate(),
    //       ),
    //     ),
    //   ),
    // );
  }
}
