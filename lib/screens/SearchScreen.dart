import 'package:brokemusicapp/components/constants.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchParam = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 24.0,
              bottom: 32.0,
            ),
            child: Material(
              elevation: 16.0,
              shadowColor: Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              child: TextField(
                onChanged: (value) {
                  print(value);
                  searchParam = value;
                },
                decoration: kSearchFieldDecoration,
                style: TextStyle(color: Colors.grey.shade900),
                onSubmitted: (value) {
                  print("We officially submit the value: $value");
                },
              ),
            ),
          ),
          SearchResultAlbumItem(),
          SearchResultAlbumItem(),
          SearchResultAlbumItem(),
          SearchResultAlbumItem(),
        ],
      ),
    );
  }
}

class SearchResultAlbumItem extends StatelessWidget {
  const SearchResultAlbumItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 88.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(kAlbumItemSearchResultBorderRadius),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(kAlbumItemSearchResultBorderRadius),
                  ),
                  child: Image.network(
                    'https://i.scdn.co/image/ab67616d0000b273c5649add07ed3720be9d5526',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.0,
                  children: [
                    Text(
                      "Blonde",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Frank Ocean",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
            height:1.0,
            color: Colors.grey.shade400,
          margin: EdgeInsets.symmetric(horizontal: 24.0),
        )
      ],
    );
  }
}
