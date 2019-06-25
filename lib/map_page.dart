import 'package:flutter/material.dart';
import 'package:off_the_map/partials/info_footer.dart';
import 'package:off_the_map/partials/map_area.dart';
import 'package:off_the_map/partials/navigation_bar.dart';

import 'constants.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlueBackground,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            NavigationBar(),
            Expanded(child: MapArea()),
            Expanded(child: InfoFooter()),
          ],
        ),
      ),
    );
  }
}
