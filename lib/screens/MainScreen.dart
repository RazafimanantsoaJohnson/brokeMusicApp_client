import 'package:brokemusicapp/components/AlbumCard.dart';
import 'package:brokemusicapp/components/FloatingPlayerButton.dart';
import 'package:brokemusicapp/components/constants.dart';
import 'package:brokemusicapp/constants.dart';
import 'package:brokemusicapp/logics/AuthBrain.dart';
import 'package:brokemusicapp/logics/Navigation.dart';
import 'package:brokemusicapp/screens/AlbumScreen.dart';
import 'package:brokemusicapp/screens/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;
  AlbumScreenProps albumData= AlbumScreenProps("", "", "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        backgroundColor: Color(kTertiaryColor),
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index){
          setState((){
            currentPageIndex = index;
          });
        },
        destinations: <Widget>[
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search')
        ],
      ),
      body: <Widget>[
        SafeArea(
          child: Center(
            child: ListView(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: kCardGap,
                  children: [
                    Expanded(
                        child:GestureDetector(
                          onTap: (){
                            setState(() {
                              currentPageIndex = 1;
                              albumData = AlbumScreenProps("https://i.scdn.co/image/ab67616d0000b273c7ea04a9b455e3f68ef82550", "Take Care", "Drake");
                            });
                          },
                          child: AlbumCard(
                            albumCoverUrl: "https://i.scdn.co/image/ab67616d0000b273c7ea04a9b455e3f68ef82550",

                          ),
                        )),
                    Expanded(child:GestureDetector(
                      onTap: (){
                        setState(() {
                          // currentPageIndex = 1;
                          // albumData = AlbumScreenProps("https://i.scdn.co/image/ab67616d0000b273c5649add07ed3720be9d5526", "Blonde", "Frank Ocean");
                          String authToken = Provider.of<AuthBrain>(context, listen: false).accessToken;
                          Provider.of<NavigationBrain>(context, listen:false).navigateToAlbumScreen("3mH6qwIy9crq0I9YQbOuDf",  authToken);
                        });
                      },
                      child: AlbumCard(
                        albumCoverUrl: "https://i.scdn.co/image/ab67616d0000b273c5649add07ed3720be9d5526",
                      ),
                    )
                    ),
                  ]
                ),
              ]
            )
          )
        ),
        AlbumScreen(albumData: albumData)
        // SearchScreen()
      ][currentPageIndex],
      floatingActionButton: FloatingPlayerButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

