import 'package:blindreader1/reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

List subSection;

class ChapterSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChapterSectionState();

  ChapterSection(List temp) {
    subSection = temp;
  }
}

class ChapterSectionState extends State<ChapterSection> {
  FlutterTts flutterTts = FlutterTts();

  @override
  initState() {
    super.initState();
    flutterTts.setVoice('en-us-x-sfg#male_1-local');
    flutterTts.setVolume(1.0);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0.0,
        // backgroundColor: Colors.white,
        title: Text(
          'Blind Reader',
          // style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: subSection.length,
        itemBuilder: (context, position) {
          return Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  flutterTts.speak('Chapter ' +
                      (position + 1).toString() +
                      ', ' +
                      subSection[position]['title']);
                },
                onLongPress: () {
                  flutterTts.speak('Opening Chapter ' +
                      (position + 1).toString() +
                      ', ' +
                      subSection[position]['title']);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ReaderPage(subSection[position]['content']),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        (position + 1).toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(subSection[position]['title']),
                    subtitle: Text(subSection[position]['subtitle']),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
