import 'package:brokemusicapp/logics/PlayerBrain.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import '../constants.dart';


class AlbumTitleItem extends StatefulWidget {
  TrackData track;
  AlbumTitleItem({super.key,required this.track});

  @override
  State<AlbumTitleItem> createState() => _AlbumTitleItemState();
}

class _AlbumTitleItemState extends State<AlbumTitleItem> {
  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(milliseconds:  widget.track.duration);
    int minutesDuration = duration.inMinutes;
    String remainingSeconds = (duration.inSeconds %60).toString().padLeft(2, '0');

    return Container(
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
                  style: kAlbumTitleTrackNumberStyle
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
                          padding: EdgeInsets.only(top: kAlbumTitleSeparatorHeight),
                          child: Text(
                              widget.track.name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade900,
                              )
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: kAlbumTitleSeparatorHeight, right: 16.0),
                            child: Text(
                              "${minutesDuration}:$remainingSeconds",
                              style: kAlbumTitleTrackNumberStyle.copyWith(
                                  fontSize: 16.0
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: kAlbumTitleSeparatorHeight,
                    color: Colors.grey.shade400,
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}