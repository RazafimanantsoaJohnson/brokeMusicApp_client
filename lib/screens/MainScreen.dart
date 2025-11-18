import 'package:brokemusicapp/components/AlbumCard.dart';
import 'package:brokemusicapp/components/FloatingPlayerButton.dart';
import 'package:brokemusicapp/components/constants.dart';
import 'package:brokemusicapp/constants.dart';
import 'package:brokemusicapp/logics/AuthBrain.dart';
import 'package:brokemusicapp/logics/Navigation.dart';
import 'package:brokemusicapp/screens/AlbumScreen.dart';
import 'package:brokemusicapp/screens/SearchScreen.dart';
import 'package:brokemusicapp/models/Albums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;
  String testAccessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJicm9rZW11c2ljYXBwIiwic3ViIjoiZWM4NzY4YWItMDcwYS00NTZmLTgxMTMtMDFmZmQ5MWViMmVjIiwiZXhwIjoxNzYzMzAwMTY5LCJpYXQiOjE3NjMyOTY1Njl9.whd0v0E3OyCL1SpVhMyBAry8DwtmGR6ntLk4exSUwLg";

  @override
  void initState() {
    super.initState();
    Provider.of<NavigationBrain>(context, listen:false).getRecentlyVisitedAlbums(testAccessToken);
  }
  
  Future<void> selectAlbum(AlbumData album) async{
    Provider.of<NavigationBrain>(context, listen:false).setAlbumData(album);
    Provider.of<NavigationBrain>(context, listen: false).showAlbumScreen();
    await Provider.of<NavigationBrain>(context, listen:false).navigateToAlbumScreen(album, testAccessToken);
  }

  List<Widget> showRecentlyVisitedAlbums(){
    List<AlbumData> albums = Provider.of<NavigationBrain>(context, listen: false).recentlyVisited;
    List<Widget> result = [];
    result.add(
        SizedBox(height: 16.0)
    );

    for(int i=0; i<albums.length; i+=2){
      bool isSingleChild = false;
      if (albums.length <= i+1){
        isSingleChild = true;
      }
      List<Widget> rowChildren = [
        SizedBox(width: 1.0),
        Expanded(
            child:GestureDetector(
              onTap: () async{
                setState(() {
                  selectAlbum(albums[i]);
                });
              },
              child: AlbumCard(
                album: albums[i],
              ),
            )
        )
      ];

      if (!isSingleChild){
        rowChildren.add(
            Expanded(
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    selectAlbum(albums[i+1]);
                  });
                },
                child: AlbumCard(
                  album: albums[i+1],
                ),
              ),
            )
        );
      } else {
        rowChildren.add(
          Expanded(
            child: Container()
          )
        );
      }
      rowChildren.add(
        SizedBox(width: 1.0)
      );

      result.add(
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: isSingleChild?MainAxisAlignment.start :MainAxisAlignment.spaceEvenly,
            spacing: kCardGap,
            children: rowChildren
        ),
      );
    }
    result.add(
      SizedBox(
        height: kAlbumScreenMarginBottom
      )
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {

    String currentUserToken = Provider.of<AuthBrain>(context).accessToken;
    bool showAlbumScreen = Provider.of<NavigationBrain>(context).isAlbumScreenVisible;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        backgroundColor: Color(kTertiaryColor),
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index){
          setState((){
            Provider.of<NavigationBrain>(context, listen:false).hideAlbumScreen();
            currentPageIndex = index;
          });
        },
        destinations: <Widget>[
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search')
        ],
      ),
      body: showAlbumScreen? AlbumScreen(): <Widget>[
        SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    spacing: 12.0,
                    children: showRecentlyVisitedAlbums()
                )
            )
        ),
        SearchScreen()
      ][currentPageIndex],
      floatingActionButton: FloatingPlayerButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

