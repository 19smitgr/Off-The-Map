import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';

class InfoFooter extends StatelessWidget {
  final Widget child;

  const InfoFooter({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      color: kGrayBackgroundColor,
      padding: EdgeInsets.all(15.0),
      child: child,
    );
  }
}
