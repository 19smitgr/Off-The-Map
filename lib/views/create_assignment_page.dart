import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:latlong/latlong.dart';
import 'package:off_the_map/constants.dart';
import 'package:off_the_map/controllers/current_place_controller.dart';
import 'package:off_the_map/controllers/footer_controller.dart';
import 'package:off_the_map/models/assignment.dart';
import 'package:off_the_map/models/place.dart';
import 'package:off_the_map/models/place_instruction_pair.dart';
import 'package:off_the_map/objects/info_window_template_widget.dart';
import 'package:off_the_map/views/partials/info_footer.dart';
import 'package:off_the_map/views/partials/map_area.dart';
import 'package:off_the_map/views/partials/text_editor.dart';
import 'package:provider/provider.dart';

/// The page for a teacher to create an assignment
class CreateAssignmentPage extends StatefulWidget {
  @override
  _CreateAssignmentPageState createState() => _CreateAssignmentPageState();
}

class _CreateAssignmentPageState extends State<CreateAssignmentPage> {
  final TextEditingController assignmentNameController =
      TextEditingController();
  final GeneralInstructionsController generalInstructionsController =
      GeneralInstructionsController();
  final SwitchController switchController = SwitchController();

  final Assignment assignment = Assignment();
  List<Place> assignmentPlaces = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrayBackgroundColor,
      appBar: AppBar(
        backgroundColor: kDarkBlueBackground,
        title: Text('Create Assignment'),
      ),
      body: ChangeNotifierProvider<SwitchController>.value(
        value: switchController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: assignmentNameController,
                decoration: InputDecoration(
                  hintText: 'Assignment title',
                  labelText: 'Enter your assignment\'s title',
                ),
                onEditingComplete: () {
                  assignment.name = assignmentNameController.text;
                  FocusScope.of(context).unfocus();
                },
              ),
              SizedBox(height: 16.0),
              RaisedButton(
                color: kPurple,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return TextEditor();
                      },
                    ),
                  ).then((val) {
                    assignment.generalInstructions = val;
                  });
                },
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      generalInstructionsController.buttonText,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Allow students to choose the location they research',
                    ),
                  ),
                  Switch(
                    value: switchController.studentChoiceEnabled,
                    onChanged: (bool studentsCanChooseLocations) {
                      setState(() {
                        switchController.studentChoiceEnabled =
                            !switchController.studentChoiceEnabled;
                        studentsCanChooseLocations =
                            switchController.studentChoiceEnabled;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Consumer<SwitchController>(
                builder: (
                  BuildContext context,
                  SwitchController switchController,
                  Widget child,
                ) {
                  return Visibility(
                    visible: !switchController.studentChoiceEnabled,
                    child: Flexible(
                      child: Column(
                        children: <Widget>[
                          RaisedButton(
                            color: kPurple,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PlaceSelectionPage();
                                  },
                                ),
                              ).then((place) {
                                // if user completed form and didn't hit the back button
                                if (place != null) {
                                  setState(() {
                                    // add to assignment
                                    assignment.placesToResearch.add(
                                      PlaceInstructionPair(
                                        placeRef: place.reference,
                                        instructions: '',
                                      ),
                                    );

                                    assignmentPlaces.add(place);
                                  });
                                }
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Add a Location for Students to Research',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (assignmentPlaces.isNotEmpty)
                            Text('Current List:'),
                          SizedBox(height: 16.0),
                          Flexible(
                            child: ListView(
                              children: <Widget>[
                                for (Place place in assignmentPlaces)
                                  PlaceButton(place: place),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),
              RaisedButton(
                color: kDarkBlueBackground,
                onPressed: () {},
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlaceButton extends StatelessWidget {
  final Place place;

  PlaceButton({@required this.place});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(place.name, style: kHeader),
        FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return TextEditor();
                },
              ),
            );
          },
          child: Text(
            'Edit Place Instructions',
            style: TextStyle(color: kLinkText),
          ),
        ),
        Divider(),
      ],
    );
  }
}

class GeneralInstructionsController {
  String buttonText = 'Write General Instructions';
}

class SwitchController with ChangeNotifier {
  bool _studentChoiceEnabled = true;

  set studentChoiceEnabled(bool enabled) {
    this._studentChoiceEnabled = enabled;
    notifyListeners();
  }

  get studentChoiceEnabled => this._studentChoiceEnabled;
}

class PlaceSelectionPage extends StatefulWidget {
  @override
  _PlaceSelectionPageState createState() => _PlaceSelectionPageState();
}

class _PlaceSelectionPageState extends State<PlaceSelectionPage> {
  final FooterController footerController = FooterController();
  final CurrentPlaceController currentPlaceController =
      CurrentPlaceController();
  final MapTapController mapTapController = MapTapController();

  List<Place> places = [];

  @override
  Widget build(BuildContext context) {
    PlacesController placesController = PlacesController();

    return Scaffold(
      backgroundColor: kGrayBackgroundColor,
      appBar: AppBar(
        backgroundColor: kDarkBlueBackground,
        title: Text('Tap on a Location'),
      ),
      body: Column(
        children: <Widget>[
          ChangeNotifierProvider<PlacesController>.value(
            value: placesController,
            child: Consumer<PlacesController>(
              builder: (BuildContext context, PlacesController placesController,
                  Widget child) {
                return Expanded(
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('places').snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snap) {
                      switch (snap.connectionState) {
                        case ConnectionState.waiting:
                          return Text('Loading...');
                        default:
                          if (snap.hasError) {
                            return Text('Error: ${snap.error}');
                          } else {
                            places = [];

                            for (DocumentSnapshot doc in snap.data.documents) {
                              places.add(Place.fromFirestore(doc));
                            }

                            placesController.places = places;

                            return MultiProvider(
                              providers: [
                                Provider<CurrentPlaceController>.value(
                                  value: currentPlaceController,
                                ),
                                Provider<List<Place>>.value(
                                  value: placesController.places,
                                ),
                              ],
                              child: ChangeNotifierProvider<
                                  MapTapController>.value(
                                value: mapTapController,
                                child: Consumer<PlacesController>(
                                  builder: (BuildContext context,
                                      PlacesController placesController,
                                      Widget child) {
                                    return MapArea(
                                      infoWindowFactory:
                                          PlaceChooserInfoWindowFactory(),
                                      mapTapCallback: (LatLng latLng) {
                                        // TODO: instead of using setstate here, use a controller and
                                        // TODO: only setstate for the footerwidget so the map doesn't reload
                                        footerController.extended =
                                            !footerController.extended;
                                        placesController.places = places;

                                        mapTapController.tappedLatLng = latLng;
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                      }
                    },
                  ),
                );
              },
            ),
          ),
          ChangeNotifierProvider<FooterController>.value(
            value: footerController,
            child: Consumer<FooterController>(
              builder: (BuildContext context, FooterController footerController,
                  Widget child) {
                return ChangeNotifierProvider<PlacesController>(
                  builder: (BuildContext context) {
                    return placesController;
                  },
                  child: Visibility(
                    visible: footerController.extended,
                    child: Expanded(
                      child: InfoFooter(
                        child: CreateNewPlace(
                            latLng: mapTapController.tappedLatLng),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PlacesController extends ChangeNotifier {
  List<Place> _places = [];

  get places => _places;
  set places(List<Place> places) {
    _places = places;
    notifyListeners();
  }
}

class MapTapController extends ChangeNotifier {
  LatLng _tappedLatLng = LatLng(0, 0);

  get tappedLatLng => _tappedLatLng;
  set tappedLatLng(LatLng latLng) {
    this._tappedLatLng = latLng;
    notifyListeners();
  }
}

class PlaceChooserInfoWindowFactory extends InfoWindowTemplate {
  @override
  Widget generateInfoWindowTemplate({Place place}) {
    return Container(
      color: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text(place.name, style: kHeader),
            Builder(builder: (BuildContext context) {
              return RaisedButton(
                onPressed: () {
                  Navigator.pop(context, place);
                },
                child: Text('Choose Place'),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class PlaceList extends StatelessWidget {
  final LatLng latLng;

  PlaceList({this.latLng});

  @override
  Widget build(BuildContext context) {
    FooterController footerController = Provider.of<FooterController>(context);
    PlacesController placesController = Provider.of<PlacesController>(context);

    List<Place> places = placesController.places;

    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Choose from the following places near where you tapped or create a new place down below.',
          ),
          // TODO: use geoflutterfire to actually get the places that are near this point. Shouldn't be hard
          Flexible(
            child: ListView(
              children: <Widget>[
                for (Place place in places)
                  RaisedButton(
                    color: kPurple,
                    onPressed: () {
                      Navigator.pop(context, place);
                    },
                    child: Text(
                      place.name,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
          FlatButton(
            onPressed: () {
              footerController.replaceFooterContent(
                CreateNewPlace(latLng: latLng),
              );
            },
            child: Text(
              'Create New Place',
              style: TextStyle(color: kLinkText),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateNewPlace extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final LatLng latLng;

  CreateNewPlace({this.latLng});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Name',
              labelText: 'Name your place',
            ),
          ),
          RaisedButton(
            color: kPurple,
            onPressed: () {
              // create the place in Firestore
              GeoFirePoint tappedLocation = Geoflutterfire().point(
                latitude: this.latLng.latitude,
                longitude: this.latLng.longitude,
              );

              Firestore.instance
                  .collection('places')
                  .add({'name': nameController.text, 'point': tappedLocation.data});

              Navigator.pop(
                  context, Place(name: nameController.text, latLng: latLng));
            },
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
