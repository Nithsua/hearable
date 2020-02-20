import 'package:blindreader1/splash.dart';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     statusBarColor: Colors.white10,
  //     statusBarIconBrightness: Brightness.dark,
  //   ),
  // );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // brightness: Brightness.dark,
        //   // primaryColor: Colors.lightBlue[800],
        //   // accentColor: Colors.cyan[600],

        //   // // // Define the default font family.
        //   // // fontFamily: 'Georgia',

        //   // // // Define the default TextTheme. Use this to specify the default
        //   // // // text styling for headlines, titles, bodies of text, and more.
        //   // // textTheme: TextTheme(
        //   // //   headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //   // //   title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        //   // //   body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        //   // // ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          // color: Colors.white10,
          // textTheme: TextTheme(
          //   title: TextStyle(color: Colors.black),
          // ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: SplashPage(),
    ),
  );
}
