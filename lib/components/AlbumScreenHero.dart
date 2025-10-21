import 'package:brokemusicapp/screens/AlbumScreen.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class AlbumScreenHero extends StatelessWidget {
  final AlbumScreenProps albumData;
  const AlbumScreenHero({super.key, required this.albumData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kAlbumScreenHeroMarginTop, bottom: kAlbumScreenHeroMarginBottom),
      width: double.infinity,
      height: kAlbumScreenHeroHeight,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Expanded(
                child: Container(
                    width: kAlbumScreenCardWidth,
                    child: Hero(
                      tag: "AlbumCover",
                      child: Image.network(
                          albumData.albumCoverUrl,
                        fit: BoxFit.fill,
                      ),
                    )
                )
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      albumData.albumName,
                      style: TextStyle(
                        // fontWeight: FontWeight.w500,
                          fontSize: kAlbumTitleFontSize,
                          fontFamily: 'BBHSansBogle'
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10.0,
                    children: [
                      Text(
                          "by",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey.shade700,
                          )
                      ),
                      Text(
                          albumData.artistName,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          )
                      )
                    ],
                  )
                ],
              ),
            )
          ]
      ),
    );
  }
}
