import 'dart:convert';

import 'package:brokemusicapp/constants.dart';
import 'package:brokemusicapp/logics/PlayerBrain.dart';
import 'package:flutter/material.dart';
import 'package:brokemusicapp/screens/AlbumScreen.dart';
import 'package:http/http.dart' as http;

class NavigationBrain extends ChangeNotifier {
  bool _isAlbumScreenVisible = false;
  late AlbumData _albumData;
  List<TrackData> _tracksData = [];

  get albumData => _albumData;
  get isAlbumScreenVisible => _isAlbumScreenVisible;
  get tracks => _tracksData;

  Future<void> navigateToAlbumScreen(String albumId, String authToken) async{
    try{
      Uri url = Uri.parse("$kServerBaseUrl/albums/$albumId/$kAlbumTracksEndpoint");
      print(url);
      http.Response response = await http.get(url,headers:{
        "Content-Type":"application/json",
      "Authorization": "Bearer $authToken"
      });
      if (response.statusCode > 299){
        // should show an 'error UI element'
        throw Exception("error happened when navigation to album screen");
      }

      List<dynamic> resBody = jsonDecode(response.body);
      _tracksData = [];
      for (int i=0; i<resBody.length; i++){
        _tracksData.add(TrackData.fromJson(resBody[i]));
      }
      _isAlbumScreenVisible= true;

      // _albumData = AlbumData.fromJson(album)
      print(_tracksData[0].youtubeUrl);
    }catch(e){
      // should show a UI element of some sort
      throw e;
    }
  }
}
