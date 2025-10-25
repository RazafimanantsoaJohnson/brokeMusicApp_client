import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class TrackData{
  late int discNumber;
  late int duration;
  late String id;
  late String name;
  late int trackNumber;
  late bool explicit;
  late String trackUri;
  late bool isAvailable;
  late String youtubeUrl;
  late String fileURL;

  TrackData({required this.discNumber, required this.duration, required this.name, required this.id, required this.trackNumber,
  this.trackUri = "", this.explicit = false, this.isAvailable= true, this.youtubeUrl= "", this.fileURL= "" });

  TrackData.fromJson(Map<String,dynamic> track){
    discNumber = track["disc_number"];
    duration = track["duration_ms"];
    explicit = track["explicit"];
    id = track["id"];
    name = track["name"];
    trackNumber = track["track_number"];
    if (track["youtube_url"] != null){
      youtubeUrl = track["youtube_url"];
      fileURL = track["youtube_url"];
    }
  }
}

class PlayerBrain extends ChangeNotifier{
  List<AudioPlayer> _playerPool = [];
  int currentlyPlayingTrackIndex = 0;

  Future<void> startAlbumPlayerPool(List<TrackData> tracks) async{
    // we will want a try-catch to handle errors
    for (int i = 0; i< tracks.length; i++){
      AudioPlayer player = AudioPlayer();
      await player.setSourceUrl(tracks[i].youtubeUrl);
      _playerPool.add(player);
    }
  }

  Future<void> playTrackAtIndex(int index) async {
    if (index == currentlyPlayingTrackIndex){
      return;
    }
    await _playerPool[currentlyPlayingTrackIndex].stop();
    currentlyPlayingTrackIndex = index;
    await _playerPool[currentlyPlayingTrackIndex].resume();
  }

  Future<void> playAlbum(List<TrackData> tracks) async {
    AudioPlayer player= AudioPlayer();
    await player.setSourceUrl(tracks[0].youtubeUrl);
    await player.resume();
    _playerPool.add(player);
    tracks.removeAt(0);
    startAlbumPlayerPool(tracks);
  }

  Future<void> next() async {
    if (_playerPool.length < (currentlyPlayingTrackIndex+1)){
      currentlyPlayingTrackIndex= 0;
      await playTrackAtIndex(0);
    }else {
      await playTrackAtIndex(currentlyPlayingTrackIndex +1);
    }
  }

  Future<void> pauseCurrentlyPlayedTrack() async{
    await _playerPool[currentlyPlayingTrackIndex].pause();
  }

}

