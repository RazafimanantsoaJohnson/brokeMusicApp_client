import 'package:flutter/material.dart';
import 'constants.dart';
import '../constants.dart';


class AlbumTitleItem extends StatefulWidget {
  const AlbumTitleItem({super.key});

  @override
  State<AlbumTitleItem> createState() => _AlbumTitleItemState();
}

class _AlbumTitleItemState extends State<AlbumTitleItem> {
  @override
  Widget build(BuildContext context) {
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
                  "1",
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
                              "Nikes",
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
                              "5:14",
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
                    color: Color(kSecondaryColor),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}