import 'package:flutter/material.dart';
import 'package:blindreader1/insection.dart';
import 'package:blindreader1/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

FlutterTts flutterTts;

Future<String> getImage(List quakeList, int position) async {
  return await FirebaseStorageService.getResource(
      quakeList[position]['imageurl']);
}

int findCategoryLength(List quakeList, String str) {
  int inc = 0;
  for (int i = 0; i < quakeList.length; ++i)
    for (int j = 0; j < quakeList[i]['category'].length; ++j)
      if (quakeList[i]['category'][j] == str) ++inc;
  return inc;
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    flutterTts = FlutterTts();
    flutterTts.setVoice('en-us-x-sfg#male_1-local');
    flutterTts.setVolume(1.0);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  _getTileValue(List quakeList, int index) async {
    return {
      'title': quakeList[index]['title'],
      'subtitle': quakeList[index]['description'],
      'imageurl': await FirebaseStorageService.getResource(
          quakeList[index]['imageurl']),
      'chapters': quakeList[index]['chapters'],
    };
  }

  filterCategory(List quakeList, String str) {
    var temp = [];
    for (int i = 0; i < quakeList.length; ++i) {
      for (int j = 0; j < quakeList[i]['category'].length; ++j) {
        if (quakeList[i]['category'][j] == str) {
          temp.add(quakeList[i]);
          break;
        }
      }
    }
    for (var i in temp) {
      print(i);
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blind Reader',
          style: TextStyle(
              // color: Colors.black,
              // fontWeight: FontWeight.bold,
              ),
        ),
        // centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            var quakeList = snap.data;
            return ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                  ),
                  child: Text(
                    'Programming',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  height: 170,
                  // width: 75,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: findCategoryLength(quakeList, 'Programming'),
                      itemBuilder: (context, position) {
                        // var cardTemp = _getTileValue(
                        //     filterCategory(quakeList, 'Programming'), position);
                        // print(cardTemp['imageurl']);
                        // print(findCategoryLength(quakeList, 'Programming'));
                        return FutureBuilder(
                          future: _getTileValue(
                              filterCategory(quakeList, 'Programming'),
                              position),
                          builder: (context, snap) {
                            var temp = snap.data;
                            if (snap.hasData) {
                              return Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Image.network(
                                      temp['imageurl'],
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Container(
                                          width: 80,
                                        );
                                      },
                                      width: 80,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    left: 20.0,
                  ),
                  child: Text(
                    'Theories',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  height: 170,
                  // width: 75,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: findCategoryLength(quakeList, 'Theories'),
                      itemBuilder: (context, position) {
                        // var cardTemp = _getTileValue(
                        //     filterCategory(quakeList, 'Programming'), position);
                        // print(cardTemp['imageurl']);
                        // print(findCategoryLength(quakeList, 'Programming'));
                        return FutureBuilder(
                          future: _getTileValue(
                              filterCategory(quakeList, 'Theories'), position),
                          builder: (context, snap) {
                            var temp = snap.data;
                            if (snap.hasData) {
                              return Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Image.network(
                                      temp['imageurl'],
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Container(
                                          width: 80,
                                        );
                                      },
                                      width: 80,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    left: 20.0,
                  ),
                  child: Text(
                    'Popular Ones',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                  child: Center(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: findCategoryLength(quakeList, 'Popular'),
                      shrinkWrap: true,
                      itemBuilder: (context, position) {
                        // Future<String> temp = getImage(position);
                        return FutureBuilder(
                          future: _getTileValue(
                              filterCategory(quakeList, 'Popular'), position),
                          builder: (context, snap) {
                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              // return Align(
                              //   child: Padding(
                              //       padding: EdgeInsets.all(20.0),
                              //       child: CircularProgressIndicator()),
                              // );
                              return Container();
                            } else {
                              var temp = snap.data;
                              return Padding(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20.0),
                                    onTap: () {
                                      print(temp['title']);
                                      flutterTts.speak(temp['title']);
                                    },
                                    onLongPress: () {
                                      flutterTts
                                          .speak('Opening ' + temp['title']);
                                      Navigator.push(
                                        context,
                                        // PageTransition(
                                        //     child: ChapterSection(
                                        //       temp['chapters'],
                                        //     ),
                                        //     type: PageTransitionType.rightToLeftWithFade),
                                        MaterialPageRoute(
                                          builder: (context) => ChapterSection(
                                            temp['chapters'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Card(
                                            margin: EdgeInsets.all(10.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(5.0),
                                              height: 125,
                                              width: 90,
                                              child: Image.network(
                                                temp['imageurl'],
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Align(
                                                    alignment: Alignment.center,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                                // height: 100,
                                                // width: 75,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                          // onTap: () {},
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                // fit: FlexFit.loose,
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10.0, 5.0, 10.0, 10.0),
                                                  child: Text(
                                                    temp['title'],
                                                    // overflow: TextOverflow.,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0,
                                                    ),
                                                    // textAlign:
                                                    //     TextAlign.justify,
                                                  ),
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10.0, 5.0, 10.0, 10.0),
                                                  child: Text(
                                                    temp['subtitle'],
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
