import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/controllers/current_place_controller.dart';
import 'package:off_the_map/controllers/current_story_controller.dart';
import 'package:off_the_map/controllers/footer_controller.dart';
import 'package:off_the_map/models/assignment.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/objects/info_window_template_widget.dart';
import 'package:off_the_map/views/partials/info_footer.dart';
import 'package:off_the_map/views/partials/map_area.dart';
import 'package:off_the_map/views/partials/navigation_bar.dart';
import 'package:off_the_map/views/partials/title_year_input_screen.dart';
import 'package:provider/provider.dart';

class StudentCompleteAssignmentPage extends StatelessWidget {
  final CurrentStoryController currentStoryController =
      CurrentStoryController();
  final CurrentPlaceController currentPlaceController =
      CurrentPlaceController();
  final List<Place> places;
  final Assignment assignment;

  StudentCompleteAssignmentPage({@required this.places, @required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: currentPlaceController,
      child: ChangeNotifierProvider(
        builder: (BuildContext context) {
          return currentStoryController;
        },
        // necessary to provide a List<Place> because Map Area depends on it
        child: Provider.value(
          value: places,
          child: ChangeNotifierProvider<FooterController>(
            builder: (context) => FooterController(),
            child: Scaffold(
              backgroundColor: kDarkBlueBackground,
              appBar: AppBar(
                backgroundColor: kDarkBlueBackground,
                title: Text(assignment.name),
                // bottom: PreferredSizeWidget()
              ),
              body: Consumer<FooterController>(
                  builder: (context, footerController, child) {
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: MapArea(
                        infoWindowFactory: InstructionsCarouselFactory(),
                        markerCustomTapCallback: () {
                          footerController.extended = true;
                        },
                      ),
                    ),
                    if (footerController.extended)
                      Expanded(
                        child: InfoFooter(
                          child: TitleYearInputScreen(),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
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
class InstructionsCarousel extends StatefulWidget {
  final List<String> buttonCaptionsByPage = [
    'See Instructions',
    'Save and Close'
  ];

  final String title;

  InstructionsCarousel({this.title});

  @override
  _InstructionsCarouselState createState() => _InstructionsCarouselState();
}

class _InstructionsCarouselState extends State<InstructionsCarousel> {
  int _pageNum = 1;
  CarouselSlider slider;

  @override
  void initState() {
    super.initState();

    slider = CarouselSlider(
      viewportFraction: 1.0,
      items: <Widget>[
        Text(widget.title),
        InstructionsScreen(),
      ],
    );
  }

  /// This keeps track of page number by changing _pageNum
  void incrementPage() {
    int maxPageNum = widget.buttonCaptionsByPage.length;
    _pageNum == maxPageNum ? _pageNum = 1 : _pageNum++;
  }

  @override
  Widget build(BuildContext context) {
    String screenChangeBtnCaption = widget.buttonCaptionsByPage[_pageNum - 1];

    return Container(
      padding: EdgeInsets.all(5.0),
      color: kOrangeMarkerColor,
      child: Column(
        children: <Widget>[
          slider,
          RaisedButton(
            onPressed: () {
              // toggle whether footer is visible
              FooterController footerController =
                  Provider.of<FooterController>(context);
              footerController.extended = !footerController.extended;

              slider.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );

              // rebuilds widget because _pageNum changed
              setState(() {
                incrementPage();
              });
            },
            child: Text(screenChangeBtnCaption),
          ),
        ],
      ),
    );
  }
}

class InstructionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text('Instructions', style: kBoldText),
          SizedBox(height: 5.0),
          Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ac lacus ac risus molestie blandit. Phasellus dignissim, magna efficitur auctor mollis, est metus ultricies elit, ac ullamcorper turpis felis interdum ex. Nam in nulla nibh. Cras id sodales arcu. Quisque viverra mauris enim, vel feugiat erat eleifend in. Mauris vel dui tortor. Ut feugiat, est ut laoreet fermentum, elit quam tristique tellus, sit amet interdum orci neque ac neque.'),
        ],
      ),
    );
  }
}
