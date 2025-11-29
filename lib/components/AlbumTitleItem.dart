import 'package:brokemusicapp/logics/AuthBrain.dart';
import 'package:brokemusicapp/logics/PlayerBrain.dart';
import 'package:brokemusicapp/models/Tracks.dart';
import 'package:brokemusicapp/models/Albums.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import '../constants.dart';

class AlbumTitleItem extends StatefulWidget {
  final TrackData track;
  final AlbumData album;
  final List<TrackData> allTracks;
  const AlbumTitleItem({super.key, required this.track, required this.album, required this.allTracks});

  @override
  State<AlbumTitleItem> createState() => _AlbumTitleItemState();
}

class _AlbumTitleItemState extends State<AlbumTitleItem> {
  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(milliseconds: widget.track.duration);
    int minutesDuration = duration.inMinutes;
    String remainingSeconds = (duration.inSeconds % 60).toString().padLeft(
      2,
      '0',
    );
    String trackName = "";
    if (widget.track.name.length >= kAlbumTitleNumberOfChars){
      trackName = (widget.track.name).substring(0, kAlbumTitleNumberOfChars);
    }else {
      trackName = widget.track.name;
    }
    String authToken = Provider.of<AuthBrain>(context).accessToken;

    return GestureDetector(
      onTap: () async{
        context.loaderOverlay.show();
        await Provider.of<PlayerBrain>(context, listen: false).playAlbum(authToken, widget.album, widget.allTracks, widget.track.trackNumber -1);
        context.loaderOverlay.hide();
      },
      child: Container(
        height: kAlbumTitleHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Text(
                  "${widget.track.trackNumber}",
                  style: kAlbumTitleTrackNumberStyle,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: kAlbumTitleSeparatorHeight,
                          ),
                          child: Text(
                            trackName,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade900,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: kAlbumTitleSeparatorHeight,
                            right: 16.0,
                          ),
                          child: Text(
                            "${minutesDuration}:$remainingSeconds",
                            style: kAlbumTitleTrackNumberStyle.copyWith(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: kAlbumTitleSeparatorHeight,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
