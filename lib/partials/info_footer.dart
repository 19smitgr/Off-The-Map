import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/partials/map_area.dart';

class InfoFooter extends StatelessWidget {
  const InfoFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kGrayBackgroundColor,
      padding: EdgeInsets.all(15.0),
      child: TitleYearInputScreen(),
    );
  }
}
