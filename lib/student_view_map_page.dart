import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:off_the_map/footer_controller.dart';
import 'package:off_the_map/info_window_template_widget.dart';
import 'package:off_the_map/partials/info_footer.dart';
import 'package:off_the_map/partials/map_area.dart';
import 'package:off_the_map/partials/navigation_bar.dart';
import 'package:off_the_map/partials/story.dart';
import 'package:off_the_map/partials/title_year_input_screen.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'current_story_controller.dart';

class StudentViewMapPage extends StatelessWidget {
  List<Story> stories = [
    Story(title: 'College Hill Park', latLng: LatLng(35.758584, -83.972536)),
    Story(title: 'Maryville College', latLng: LatLng(35.759, -83.972536)),
    Story(title: 'Municipal Building', latLng: LatLng(35.758584, -83.973)),
    Story(title: 'House Cafe', latLng: LatLng(35.759, -83.973))
  ];

  CurrentStoryController currentStoryController = CurrentStoryController();

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: currentStoryController,
      child: Provider.value(
        value: stories,
        child: ChangeNotifierProvider<FooterController>(
          builder: (context) => FooterController(),
          child: Scaffold(
            backgroundColor: kDarkBlueBackground,
            body: SafeArea(
              child: Consumer<FooterController>(
                  builder: (context, footerController, child) {
                return Column(
                  children: <Widget>[
                    NavigationBar(),
                    Expanded(
                      child: MapArea(
                        infoWindowFactory: InstructionsCarouselFactory(),
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
  generateInfoWindowTemplate({@required Story story}) {
    return InstructionsCarousel(title: story.title);
  }
}

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

  CarouselSlider slider;

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
