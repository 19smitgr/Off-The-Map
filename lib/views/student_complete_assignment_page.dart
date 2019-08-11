import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/controllers/current_place_controller.dart';
import 'package:off_the_map/controllers/footer_controller.dart';
import 'package:off_the_map/models/assignment.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/models/uncompleted_assignment.dart';
import 'package:off_the_map/objects/info_window_marker.dart';
import 'package:off_the_map/objects/info_window_template_widget.dart';
import 'package:off_the_map/views/partials/info_footer.dart';
import 'package:off_the_map/views/partials/map_area.dart';
import 'package:off_the_map/views/partials/title_year_input_screen.dart';
import 'package:provider/provider.dart';

/// the place for a user to complete an assignment
class StudentCompleteAssignmentPage extends StatelessWidget {
  final List<Place> places;
  final Assignment assignment;
  final UncompletedAssignment uncompletedAssignment;

  StudentCompleteAssignmentPage(
      {@required this.places, @required this.assignment})
      : uncompletedAssignment =
            UncompletedAssignment.fromAssignmentTemplate(assignment);

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: places,
      child: ChangeNotifierProvider<FooterController>(
        builder: (context) => FooterController(),
        child: Scaffold(
          backgroundColor: kDarkBlueBackground,
          appBar: AppBar(
            backgroundColor: kDarkBlueBackground,
            title: Text(assignment.name),
          ),
          body: Consumer<FooterController>(
              builder: (context, footerController, child) {
                // print('line 47');
                // print(CurrentPlaceController.currentPlace.reference);
            return Column(
              children: <Widget>[
                Expanded(
                  child: MapArea(
                    infoWindowFactory: InstructionsCarouselFactory(),
                    markerCustomTapCallback: () {
                      footerController.extended =
                          !footerController.extended;
                    },
                  ),
                ),
                if (footerController.extended)
                  Expanded(
                    child: InfoFooter(
                      child: TitleYearInputScreen(story: uncompletedAssignment.places[CurrentPlaceController.currentPlace.reference]),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

/// template for the info windows in the student assignment page
class InstructionsCarouselFactory implements InfoWindowTemplate {
  @override
  generateInfoWindowTemplate({@required Place place}) {
    return InstructionsCarousel(title: place.name);
  }
}

/// stateful widget because it is only used by one widget
/// It is a separate class for the sake of complexity management
///
/// If this class is ever made into its own file, then I will convert to stateless for consistency
class InstructionsCarousel extends StatelessWidget {
  final String title;

  InstructionsCarousel({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.3,
      padding: EdgeInsets.all(5.0),
      color: kOrangeMarkerColor,
      child: Column(
        children: <Widget>[
          Text(title),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('Instructions', style: kBoldText),
                  SizedBox(height: 5.0),
                  Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ac lacus ac risus molestie blandit. Phasellus dignissim, magna efficitur auctor mollis, est metus ultricies elit, ac ullamcorper turpis felis interdum ex. Nam in nulla nibh. Cras id sodales arcu. Quisque viverra mauris enim, vel feugiat erat eleifend in. Mauris vel dui tortor. Ut feugiat, est ut laoreet fermentum, elit quam tristique tellus, sit amet interdum orci neque ac neque.'),
                ],
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              // toggle whether footer is visible
              FooterController footerController =
                  Provider.of<FooterController>(context);

              footerController.extended = !footerController.extended;

              InfoWindowMarker.closeAllInfoWindows();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
