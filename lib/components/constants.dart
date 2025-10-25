import 'package:flutter/material.dart';

const kCardWidth = 200.0;
const kCardHeight= 250.0;

const kTestAlbumUrl = "https://i.scdn.co/image/ab67616d0000b273c5649add07ed3720be9d5526";
const kAlbumTitleFontSize = 32.0;
const kAlbumScreenHeroHeight = 340.0;
const kAlbumScreenHeroWidth = 200.0;
const kAlbumScreenHeroMarginTop = 50.0;
const kAlbumScreenHeroMarginBottom = 16.0;
const kAlbumScreenCardWidth = 300.0;

const kAlbumTitleSeparatorHeight = 4.0;
const kAlbumTitleHeight = 64.0;

const kCardGap = 10.0;
const kAlbumItemSearchResultBorderRadius = 16.0;

var kAlbumTitleTrackNumberStyle = TextStyle(
    color: Colors.grey.shade700,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
);

var kSearchFieldDecoration = InputDecoration(
    hintText: 'Enter an artist or an album',
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(20.0))
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade800, width:2.0),
        borderRadius: BorderRadius.all(Radius.circular(20.0))
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.5),
        borderRadius: BorderRadius.all(Radius.circular(20.0))
    ),
    prefixIcon: Icon(Icons.search),
    suffixIcon: Icon(
        Icons.clear,
    ),
);
