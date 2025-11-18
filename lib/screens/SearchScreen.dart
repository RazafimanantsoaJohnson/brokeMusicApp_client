import 'package:brokemusicapp/components/constants.dart';
import 'package:brokemusicapp/logics/AuthBrain.dart';
import 'package:brokemusicapp/logics/Navigation.dart';
import 'package:brokemusicapp/models/Albums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchParam = "";
  List<AlbumData> searchResult = [];

  @override
  Widget build(BuildContext context) {
    String currentUserAccessToken = Provider.of<AuthBrain>(context).accessToken;
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
              elevation: 4.0,
              shadowColor: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.white,
              child: TextField(
                onChanged: (value) {
                  searchParam = value;
                },
                decoration: kSearchFieldDecoration,
                style: TextStyle(color: Colors.grey.shade900),
                onSubmitted: (value) async{
                  searchResult = await Provider.of<NavigationBrain>(context, listen:false).searchAlbum(currentUserAccessToken, searchParam);
                  setState(() {});
                },
              ),
            ),
          ),
          showSearchResults()
          
        ],
      ),
    );
  }

  Widget showSearchResults(){
    List<Widget> result = [];
    if (searchResult.length ==0){
      return SizedBox(height:0);
    }
    for (int i=0; i<searchResult.length; i++){
      result.add(SearchResultAlbumItem(album: searchResult[i], onTap: onTapSearchResult,));
    }
    return Expanded(
      child: ListView(
        children: result,
      ),
    );
  }

  Future<void> onTapSearchResult(AlbumData album,String authToken) async{
    await Provider.of<NavigationBrain>(context, listen: false).navigateToAlbumScreen(album, authToken);
    setState(() {
      Provider.of<NavigationBrain>(context, listen:false).setAlbumData(album);
      Provider.of<NavigationBrain>(context, listen: false).showAlbumScreen();
    });
  }
}

class SearchResultAlbumItem extends StatelessWidget {
  final AlbumData album;
  final Function onTap;
  const SearchResultAlbumItem({super.key, required this.album, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String currentUserAuthToken = Provider.of<AuthBrain>(context).accessToken;

    return GestureDetector(
      onTap: (){onTap(album, currentUserAuthToken);},
      child: Column(
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
                  padding: EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(kAlbumItemSearchResultBorderRadius),
                    ),
                    child: Image.network(
                      album.albumCoverUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.0,
                      children: [
                        Text(
                          album.name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          album.artistName,
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
      ),
    );
  }
}
