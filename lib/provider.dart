import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// List quakeList;
String apiURL;

getData() async {
  apiURL = await FirebaseStorageService.getResource('data.json');
  var quakeList = await FirebaseStorageService.getData(apiURL);
  return quakeList;
}

class FirebaseStorageService extends ChangeNotifier {
  FirebaseStorageService();

  static Future<dynamic> getResource(String resource) async {
    return await FirebaseStorage.instance
        .ref()
        .child(resource)
        .getDownloadURL();
  }

  static Future<List> getData(String url) async {
    http.Response response = await http.get(url);
    return jsonDecode(response.body);
  }
}
