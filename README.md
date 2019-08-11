# Off the Map

Off the Map is an app that allows people to write and maintain information about places. The goal of Off the Map is to allow people to create walking tours with these places and provide functionality to teachers to create local history research assignments for their students.

Right now, the ability to create and write about places as well as the teacher/student functionality is almost complete. However, most of the tools to create walking tours and private maps are not complete.

## Getting Started

For developers new to Dart that have programmed in Java, check out the tutorial: [From Java to Dart](https://codelabs.developers.google.com/codelabs/from-java-to-dart/)

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## Project Organization

This project is organized by the MVC structure, meaning that my database models are in `./models`, the UI is stored in `./views`, and the controllers that control the data in my views are in `./controllers`

Some miscallaneous objects that don't fit into the MVC structure are stored in `./objects`. Specifically, there are two files containing code for the info windows (See [Google's Example of an Info Window](https://developers.google.com/maps/documentation/javascript/examples/infowindow-simple) for more info). There are also two files for what I called `Named References`. I used Named References throughout the projcet to give more information about a reference, without storing the whole document that the reference points to. Mainly, I used it so that I could make a list of Story titles, and when the user clicks on the story title, the app connects to the database via the reference to retrieve the data about the story.

## 3rd Party Libraries 
(Note: All libraries documentation comes from pub.dev)
1. **Flutter Map**: A Dart port of Leaflet, the open source JavaScript map API. Basically an alternative to using Google Maps API because Google Maps is more expensive than 3rd party options.
2. **Provider**: A clean way to provide global variables to widgets that are far down in the widget structure. Then, that widget can make a change to the global variable which will then be reflected in any widget that consumes the class that was provided above in the widget tree.
3. **Zefyr**: The rich text editor that you'll see in `./views/partials/text_editor.dart`.
4. **Cloud Firestore**: Firestore is a realtime database that is very easy to setup and use. This library interfaces with Google's Firestore API.
5. **Firebase Auth**: Used for Google's free to use Email/Password sign up/log in
6. **Model Progress HUD**: Makes it easy to create a loading spinner when an asynchronous request has not yet returned.
7. **Firebase Storage**: Used to store images from the text editor. Katie also has said she also wants the ability to record and playback audio within walking tours in the app. Audio would also be stored in this database.
8. **Firebase Core**: Many of the other Google libraries used in this app depend on this parent library.
9. **UUID**: Used to create unique IDs for images when creating image names to push to the Firebase Storage database
10. **GeoFlutterFire**: The last library added to this project and consequently has not been utilized heavily. GeoFlutterFire allows you to make requests from Cloud Firestore based on physical distance from a given point. In other words, it would allow you to only load points that are within a user's viewing area.

## What's Currently Lacking:
1. Users cannot search for places and addresses within the map pages
2. There is no tutorial for new users
3. There is no payment system for different groups to separately pay for their use of the app
4. There is no ability to add audio to places
5. The UI overflows when testing on devices that are too small because the widgets are not wrapped in widgets that scroll.
6. There is no ability to create walking tours. Note that users should be able to:
  - Verify walking tours by actually walking them
  - See their approximate location in real time as they walk the tour
  - Edit and delete walking tours
7. Currently all places are loaded instead of only loading the places that are within the viewing area of a user's phone
8. Aside from the gear icon on the home page, there isn't much development in the way of creating private maps for cities that do not want just anyone to tamper with their walking tours/places
9. The Create an Assignment page for teachers does not yet return an Assignment object and consequently does not write the assignment to the database.
10. There is currently no distinction between places that have been submitted by students and places that have not been submitted by students to the "global map." Students also cannot "Submit" assignments yet, although the UI to complete an assignment exists.
11. General instructions are not yet shown before a student begins an assignment