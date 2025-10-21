import 'package:flutter/material.dart';
import 'constants.dart';

class AlbumScreenHero extends StatelessWidget {
  const AlbumScreenHero({super.key});

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
                    child: Image.network(
                        kTestAlbumUrl,
                      fit: BoxFit.fill,
                    )
                )
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "blonde",
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
                          "Frank Ocean",
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
