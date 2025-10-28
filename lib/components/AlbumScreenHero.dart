import 'dart:ui';

import 'package:brokemusicapp/logics/Navigation.dart';
import 'package:brokemusicapp/screens/AlbumScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

class AlbumScreenHero extends StatelessWidget {
  const AlbumScreenHero({super.key});

  @override
  Widget build(BuildContext context) {
    AlbumData albumToShow = Provider.of<NavigationBrain>(context, listen:false).albumData;
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
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                        child: Container(
                          color: Colors.white.withAlpha(50),
                            width: kAlbumScreenHeroWidth,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Hero(
                                tag: "AlbumCover",
                                child: Image.network(
                                  albumToShow.albumCoverUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                        ),
                      ),
                ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      albumToShow.name,
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
                          albumToShow.artistName,
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
