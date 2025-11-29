import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:brokemusicapp/constants.dart';
import 'package:brokemusicapp/models/Albums.dart';
import 'package:flutter/material.dart';
import 'package:brokemusicapp/models/Tracks.dart';
import 'package:http/http.dart' as http;

class PlayerBrain extends ChangeNotifier{
  List<AudioPlayer> _playerPool = [];
  int currentlyPlayingTrackIndex = 0;
  late AlbumData currentlyPlayingAlbum;
  bool _currentPlayStatus = false;
  List<TrackData> _tracks = [];

  get currentPlayStatus => _currentPlayStatus;
  TrackData? getCurrentTrack(){
    if (_playerPool.length == 0){
      return null;
    }
    return _tracks[currentlyPlayingTrackIndex];
  }
  AlbumData? getCurrentlyPlayedAlbum(){
    if (_playerPool.length == 0){
      return null;
    }
    return currentlyPlayingAlbum;
  }

  Future<void> startAlbumPlayerPool(String authToken, String albumId ,List<TrackData> tracks) async{
    // we will want a try-catch to handle errors
    try {
      for (int i = 0; i< tracks.length; i++){
        AudioPlayer player= AudioPlayer();
        String trackUrl = await getTrackStreamUrl(authToken, albumId, tracks[i]);
        player.setSourceUrl(trackUrl);
        _playerPool.add(player);
      }
    }catch(e){
      rethrow;
    }
  }

  Future<void> playTrackAtIndex(int index) async {
    if (index == currentlyPlayingTrackIndex){
      return;
    }
    await _playerPool[currentlyPlayingTrackIndex].stop();
    currentlyPlayingTrackIndex = index;
    _currentPlayStatus = true;
    await _playerPool[currentlyPlayingTrackIndex].resume();
  }

  Future<void> playAlbum(String authToken, AlbumData album, List<TrackData> tracks, int trackIndex) async {
    try{
      if (_tracks.isNotEmpty &&  currentlyPlayingAlbum.id != album.id){
        await destroyCurrentPlayers();
      }
      List<TrackData> tmpTrack = [...tracks];
      currentlyPlayingTrackIndex = trackIndex;
      currentlyPlayingAlbum = album;
      _tracks= [...tracks];
      _playerPool = [];
      AudioPlayer player= AudioPlayer();
      String firstTrackUrl = await getTrackStreamUrl(authToken, album.id, tmpTrack[trackIndex]);
      await player.setSourceUrl(firstTrackUrl);
      await player.resume();

      player.onPlayerComplete.listen((event){
        next();
      });

      _playerPool.add(player);
      _currentPlayStatus = true;

      tmpTrack.removeAt(0);
      startAlbumPlayerPool(authToken, album.id ,tmpTrack);
      notifyListeners();
    }catch(e){
      _currentPlayStatus = false;
      rethrow;
    }
  }

  Future<void> next() async {
    print(currentlyPlayingTrackIndex);
    if (_playerPool.length <= (currentlyPlayingTrackIndex+1)){
      await _playerPool[currentlyPlayingTrackIndex].stop();
      currentlyPlayingTrackIndex= 0;
      await playTrackAtIndex(0);
      notifyListeners();
    }else {
      await playTrackAtIndex(currentlyPlayingTrackIndex +1);
      notifyListeners();
    }
  }

  Future<void> destroyCurrentPlayers() async{
    for (int i=0; i<_playerPool.length; i++){
      await _playerPool[i].dispose();
    }
  }

  Future<void> pauseCurrentlyPlayedTrack() async{
    _currentPlayStatus = false;
    await _playerPool[currentlyPlayingTrackIndex].pause();
    notifyListeners();
  }
  Future<void> resumeCurrentTrack() async{
    _currentPlayStatus = true;
    await _playerPool[currentlyPlayingTrackIndex].resume();
    notifyListeners();
  }

  Future<String> getTrackStreamUrl(String authToken,String albumId ,TrackData track) async{
    try{
      // if fileUrl good if youtubeUrl (get the track right away it will be faster than trying to play a 403)
      print(track.fileURL);
      String streamUrl= '${kServerBaseUrl}albums/$albumId/tracks/${track.id}/stream';
      if (track.fileURL != ""){
        return streamUrl;
      }
      Uri url = Uri.parse("$kServerBaseUrl/albums/$albumId/tracks/${track.id}?retry=true");
      print(url);
      http.Response response = await http.get(url, headers:{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken'
      });
      Map<String, dynamic> resBody = jsonDecode(response.body);
      TrackData refreshedTrackData = TrackData.fromJson(resBody);
      if (track.fileURL != ""){
        return streamUrl;
      }
      return refreshedTrackData.youtubeUrl;
    }catch(e){
      rethrow;
    }
  }

}

