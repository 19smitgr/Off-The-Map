import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';

class InfoFooter extends StatelessWidget {
  const InfoFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: kGrayBackgroundColor,
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
                'Instructions',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ac lacus ac risus molestie blandit. Phasellus dignissim, magna efficitur auctor mollis, est metus ultricies elit, ac ullamcorper turpis felis interdum ex. Nam in nulla nibh. Cras id sodales arcu. Quisque viverra mauris enim, vel feugiat erat eleifend in. Mauris vel dui tortor. Ut feugiat, est ut laoreet fermentum, elit quam tristique tellus, sit amet interdum orci neque ac neque.')
          ],
        ),
      ),
    );
  }
}
