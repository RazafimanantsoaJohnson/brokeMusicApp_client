import 'dart:convert';

import 'package:brokemusicapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:brokemusicapp/models/Albums.dart';
import 'package:http/http.dart' as http;
import 'package:brokemusicapp/models/Tracks.dart';

class NavigationBrain extends ChangeNotifier {
  bool _isAlbumScreenVisible = false;
  late AlbumData _albumData;
  List<TrackData> _tracksData = [];
  List<AlbumData> _recentlyVisitedAlbums = [];

  get albumData => _albumData;
  get isAlbumScreenVisible => _isAlbumScreenVisible;
  get tracks => _tracksData;
  get recentlyVisited => _recentlyVisitedAlbums;

  void setAlbumData(AlbumData album){
    _albumData = album;
    notifyListeners();
  }

  void showAlbumScreen(){
    _isAlbumScreenVisible = true;
    notifyListeners();
  }
  void hideAlbumScreen(){
    _isAlbumScreenVisible = false;
    notifyListeners();
  }

  Future<void> navigateToAlbumScreen(AlbumData album, String authToken) async{
    try{
      String albumId = album.id;
      Uri url = Uri.parse("$kServerBaseUrl/albums/$albumId/$kAlbumTracksEndpoint");
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

      notifyListeners();
    }catch(e){
      // should show a UI element of some sort
      throw e;
    }
  }

  Future<void> getRecentlyVisitedAlbums(String authToken) async{
    try{
      Uri url = Uri.parse("$kServerBaseUrl/users/favorites");
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken'
      });
      if (response.statusCode > 299){
        throw Exception(response.body);
      }
      List<dynamic> resBody = jsonDecode(response.body);

      _recentlyVisitedAlbums =[];
      for (int i=0; i<resBody.length; i++){
        _recentlyVisitedAlbums.add(AlbumData.fromRecentlyVisitedJson(resBody[i]));
      }
      notifyListeners();
    }catch(e){
      rethrow;
    }
  }

  Future<List<AlbumData>> searchAlbum(String authToken, String searchParam) async{
    try{
      List<AlbumData> searchResult = [];
      Uri url = Uri.parse("$kServerBaseUrl/$kAlbumSearchEndpoint?query=$searchParam");
      http.Response response = await http.get(url, headers: {
        "Authorization": "Bearer $authToken"
      });
      Map<String,dynamic> resBody = jsonDecode(response.body);
      List<dynamic> albums = resBody["albums"]["items"];
      for (int i=0; i<albums.length; i++){
        searchResult.add(AlbumData.fromJson(albums[i]));
      }
      return searchResult;
    }catch(e){
      rethrow;
    }
  }

}
