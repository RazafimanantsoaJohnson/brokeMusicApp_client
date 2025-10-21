import 'package:flutter/material.dart';
import 'dart:ui';
import './constants.dart';

class AlbumCard extends StatelessWidget {
  AlbumCard({super.key, required this.albumCoverUrl});
  String albumCoverUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Stack(
        children: [
          Container(),

          BackdropFilter(
              filter: ImageFilter.blur(sigmaX:3.0, sigmaY:3.0),
              child: Container(
                color: Colors.white.withAlpha(30),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  height: kCardHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
              )
          ),
          Container(
            height: kCardHeight,
            padding: EdgeInsets.all(10.0),
            child:Hero(
              tag: "AlbumCover",
              child: Image.network(
                albumCoverUrl,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ]
      ),
    );
  }
}

