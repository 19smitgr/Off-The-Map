import 'package:flutter/material.dart';
import 'package:off_the_map/footer_controller.dart';
import 'package:off_the_map/partials/info_footer.dart';
import 'package:off_the_map/partials/map_area.dart';
import 'package:off_the_map/partials/navigation_bar.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FooterController>(
      builder: (context) => FooterController(),
      child: Scaffold(
        backgroundColor: kDarkBlueBackground,
        body: SafeArea(
          child: Consumer<FooterController>(
            builder: (context, footerController, child) { 
              return Column(
                  children: <Widget>[
                    NavigationBar(),
                    Expanded(child: MapArea()),
                    if (footerController.extended)
                      Expanded(child: InfoFooter()),
                  ],
                );
            }
          ),
        ),
      ),
    );
  }
}
