import 'package:flutter/material.dart';
import 'package:off_the_map/views/login_page.dart';
import 'package:off_the_map/views/teacher_home.dart';

void main() => runApp(OffTheMap());

class OffTheMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
