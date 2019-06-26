import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/partials/title_year_input_screen.dart';

class InfoFooter extends StatelessWidget {
  const InfoFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      color: kGrayBackgroundColor,
      padding: EdgeInsets.all(15.0),
      child: TitleYearInputScreen(),
    );
  }
}
