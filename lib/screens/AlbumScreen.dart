import 'package:brokemusicapp/components/AlbumScreenHero.dart';
import 'package:brokemusicapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:brokemusicapp/components/AlbumTitleItem.dart';

class AlbumScreenProps {
  late String albumCoverUrl;
  late String albumName;
  late String artistName;

  AlbumScreenProps(String cover, String name,String artist){
    albumCoverUrl= cover;
    albumName = name;
    artistName = artist;
  }
}

class AlbumScreen extends StatefulWidget {
  final AlbumScreenProps albumData;
  const AlbumScreen({super.key, required this.albumData});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AlbumScreenHero(albumData: widget.albumData),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 56.0),
            child: FloatingActionButton.extended(
                onPressed: (){},
              backgroundColor: Color(kSecondaryColor),
                label: Text(
                    "Play",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  )
                ),
              icon: Icon(
                Icons.play_arrow_rounded,
                size: 40.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 32.0),
          AlbumTitleItem(),
          AlbumTitleItem(),
        ],
      ),
    );
  }
}


