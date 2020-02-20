import 'package:flutter/material.dart';

String transcription;

class SearchPage extends StatefulWidget {
  SearchPage(String str) {
    transcription = str;
  }

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blind Reader',
          style: TextStyle(),
        ),
      ),
    );
  }
}
