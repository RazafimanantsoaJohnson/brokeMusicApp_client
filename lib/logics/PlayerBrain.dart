import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:brokemusicapp/models/Tracks.dart';

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

