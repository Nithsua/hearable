import 'dart:io';

import 'package:blindreader/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

String content;
var tmp;
var playerIcon = Icons.play_arrow;
int readerPosition;

readerData() async {
  String temp = await FirebaseStorageService.getResource(content);
  return await FirebaseStorageService.getData(temp);
}

// enum TtsState { playing, stopped }

class ReaderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReaderPageState();

  ReaderPage(String url) {
    content = url;
  }
}

class ReaderPageState extends State<ReaderPage> {
  FlutterTts flutterTts = FlutterTts();
  // TtsState ttsState = TtsState.stopped;
  @override
  initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    readerPosition = 0;
    flutterTts.setVoice('en-us-x-sfg#male_1-local');
    flutterTts.setVolume(1.0);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // elevation: 0.0,
      //   // backgroundColor: Colors.white,
      //   title: Text(
      //     'Blind Reader',
      //     // style: TextStyle(color: Colors.black),
      //   ),
      //   centerTitle: true,
      // ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          FutureBuilder(
            future: readerData(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting)
                return Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              else {
                tmp = snap.data;
                print(tmp.length);
                return Container(
                  padding: EdgeInsets.all(20.0),
                  child: ListView.builder(
                    itemCount: tmp.length,
                    itemBuilder: (context, position) {
                      return Text(
                        tmp[position]['content'] + '\n',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.justify,
                      );
                    },
                  ),
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Material(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30.0),
                            onTap: () {
                              flutterTts.speak('From Beginning');
                            },
                            onLongPress: () {
                              setState(() {
                                readerPosition = 0;
                                playerIcon = Icons.pause;
                              });

                              flutterTts.speak(tmp[readerPosition]['content']);

                              sleep(Duration(seconds: 1));
                            },
                            child: GestureDetector(
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 40.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30.0),
                            onTap: () {
                              flutterTts.speak('Previous Paragraph');
                            },
                            onLongPress: () {
                              setState(() {
                                if (readerPosition > 0) --readerPosition;
                                playerIcon = Icons.pause;
                              });

                              flutterTts.speak(tmp[readerPosition]['content']);
                            },
                            child: GestureDetector(
                              child: Icon(
                                Icons.fast_rewind,
                                size: 40.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30.0),
                            onTap: () {
                              if (playerIcon == Icons.play_arrow)
                                flutterTts.speak('Play');
                              else if (playerIcon == Icons.pause)
                                flutterTts.speak('Pause');
                            },
                            onLongPress: () async {
                              if (playerIcon == Icons.play_arrow) {
                                setState(() {
                                  playerIcon = Icons.pause;
                                  // ttsState = TtsState.playing;
                                });

                                await flutterTts
                                    .speak(tmp[readerPosition]['content']);
                                // sleep(Duration(seconds: 1));

                              } else if (playerIcon == Icons.pause) {
                                var result = await flutterTts.stop();
                                if (result == 1) {
                                  setState(() {
                                    playerIcon = Icons.play_arrow;
                                    // ttsState = TtsState.playing;
                                  });
                                }
                              }
                            },
                            child: GestureDetector(
                              child: Icon(
                                playerIcon,
                                size: 40.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30.0),
                            onTap: () {
                              flutterTts.speak('Next Paragraph');
                            },
                            onLongPress: () {
                              setState(() {
                                if (readerPosition < (tmp.length - 1))
                                  ++readerPosition;
                                playerIcon = Icons.pause;
                              });

                              flutterTts.speak(tmp[readerPosition]['content']);

                              sleep(Duration(seconds: 1));
                            },
                            child: GestureDetector(
                              child: Icon(
                                Icons.fast_forward,
                                size: 40.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30.0),
                            onTap: () {
                              flutterTts.speak('Final Paragraph');
                            },
                            onLongPress: () {
                              setState(() {
                                readerPosition = tmp.length - 1;
                                playerIcon = Icons.pause;
                              });
                              flutterTts.speak(tmp[readerPosition]['content']);
                            },
                            child: GestureDetector(
                              child: InkWell(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 40.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    flutterTts.speak('Back');
                  },
                  child: GestureDetector(
                    onLongPress: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
