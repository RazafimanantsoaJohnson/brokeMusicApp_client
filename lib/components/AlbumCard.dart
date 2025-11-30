import 'package:brokemusicapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:brokemusicapp/models/Albums.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';
import 'dart:ui';
import './constants.dart';

class AlbumCard extends StatelessWidget {
  AlbumCard({super.key, required this.album});
  AlbumData album;

  @override
  Widget build(BuildContext context) {
    return GlassMorphismContainer(
      opacity: 0.15,
      glassThickness: 2.0,
      blurIntensity: 23,
      tintColor: Color(kPlayerBackground),
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        height: kCardHeight,
        padding: EdgeInsets.all(10.0),
        child: Image.network(album.albumCoverUrl, fit: BoxFit.fill),
      ),
    );
  }
}
