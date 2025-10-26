import 'package:brokemusicapp/PlayerBrain.dart';
import 'package:brokemusicapp/components/AlbumScreenHero.dart';
import 'package:brokemusicapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:brokemusicapp/components/AlbumTitleItem.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'PlayerScreen.dart';

class AlbumData {
  late String id;
  late String name;
  late String albumType;
  late int totalTracks;
  late String albumUrl;
  late String releaseDate;
  late String releaseDatePrecision;
  late String type;
  late String artistName;
  late String albumCoverUrl;

  AlbumData({required this.id, required this.name, required this.albumType, required this.totalTracks, required this.albumUrl,
  required this.releaseDate, required this.releaseDatePrecision, required this.type, required this.artistName, required this.albumCoverUrl});

  AlbumData.fromJson(Map<String,dynamic> album){
    id = album["id"];
    name = album["name"];
    albumType = album["albumType"];
    totalTracks = album["total_tracks"];
    albumUrl = album["albumUrl"];
    releaseDate = album["release_date"];
    releaseDatePrecision = album["release_date_precision"];
    type = album["type"];
    artistName = album["artist"];
    albumCoverUrl = album["album_cover"];
  }
}

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
  int numberOfRetry = 0;
  bool isSongPlaying = false;
  final player = AudioPlayer();
  List<Map<String,dynamic>> ttracks = [];
  List<TrackData> tTracks = [];

  @override
  void initState() {
    super.initState();

    ttracks = [
      {
        "disc_number": 0,
        "duration_ms": 261290,
        "explicit": false,
        "id": "b77f7f49-4e94-4020-be5e-93e8f12343ae",
        "name": "ENTROPY",
        "track_number": 1,
        "uri": "",
        "is_available": true,
        "youtube_url": "https://rr6---sn-h50gpup0nuxaxjvh-hg0k.googlevideo.com/videoplayback?expire=1761440009&ei=qRz9aKHcIp2m0u8P0bqf6Q0&ip=102.115.16.96&id=o-AM9Oeuz9lNy2Rvh4ECyqNddz5TJN9WbiLg6RCHm-CVuq&itag=140&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1761418409%2C&mh=UA&mm=31%2C29&mn=sn-h50gpup0nuxaxjvh-hg0k%2Csn-4g5edndy&ms=au%2Crdu&mv=m&mvi=6&pl=23&rms=au%2Cau&initcwndbps=1733750&bui=AdEuB5TJ9wj78swbGU8VqTuuJtAF9d8sTwxvGTFGoppCBMwzanmbnP7USyRW4uaZkXldWZt5aygsoM1d&spc=6b0G_D2LqO1b&vprv=1&svpuc=1&mime=audio%2Fmp4&rqh=1&gir=yes&clen=4231482&dur=261.410&lmt=1746195276619483&mt=1761418186&fvip=1&keepalive=yes&fexp=51552689%2C51565115%2C51565681%2C51580968&c=ANDROID&txp=5318224&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRAIgYVv2Fv9YLDZYG5qMM09x5VSIAnykQO1Y9EGalfmLOW8CIFHOyjyKH2XUmd3_PnMii9anhk6kKOPCHSws-Q7GvaE9&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=APaTxxMwRQIhAKh0CCZ5s1UpdyJaz5ih89T3TzPdhNNMI3x-2pBDHvk9AiBHeXo8AP9NQmBOCAWuylUwDGkNzq0SBSYdNZkmdl_lGw%3D%3D",
        "file_url": ""
      },
      {
        "disc_number": 0,
        "duration_ms": 194959,
        "explicit": true,
        "id": "64c2bdbb-6e1e-4bbd-98a8-ae7afe3c2de9",
        "name": "CYANIDE",
        "track_number": 2,
        "uri": "",
        "is_available": true,
        "youtube_url": "https://rr7---sn-h50gpup0nuxaxjvh-hg0k.googlevideo.com/videoplayback?expire=1761440010&ei=qRz9aJSMO9PQ6dsPkIz2qAg&ip=102.115.16.96&id=o-AOZ2C9I0FWU2xqmeyu8MpJdR07wGEOXCs4TmTR4S5VtT&itag=140&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1761418409%2C&mh=6l&mm=31%2C29&mn=sn-h50gpup0nuxaxjvh-hg0k%2Csn-4g5edn6r&ms=au%2Crdu&mv=m&mvi=7&pl=23&rms=au%2Cau&pcm2=yes&initcwndbps=1682500&bui=AdEuB5QMS_kNIP9JJ2U0TiWHp6MAxYFoK8MfLl1aFH3LcDA6pbIIPvSagNnTcCQrcuObLWGZVMfN3QEH&spc=6b0G_M4-nYqd&vprv=1&svpuc=1&mime=audio%2Fmp4&rqh=1&gir=yes&clen=3158187&dur=195.094&lmt=1754259599563098&mt=1761417950&fvip=1&keepalive=yes&fexp=51552689%2C51565115%2C51565682%2C51580968&c=ANDROID&txp=5318224&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cpcm2%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRgIhAKrNnNLuE4Z2nb5mqPhyB8ovt0ikDlSg7la5c6WcDfD3AiEAnSaAZnwui1cnawINJYFhftZPv9aWieiNfIP9idAcRmI%3D&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=APaTxxMwRQIhANYzhfg-cMGxsWpapDSHej8aerervTpkjlvn6akdPJooAiB5L-vpDAq3gWFXp2whEMrQaGaIJMVHLLOrv79SHBQVGA%3D%3D",
        "file_url": ""
      },
      {
        "disc_number": 0,
        "duration_ms": 214277,
        "explicit": false,
        "id": "11c36f1a-47ff-407b-8bdf-a82c2c78a7b5",
        "name": "LOVE AGAIN",
        "track_number": 3,
        "uri": "",
        "is_available": true,
        "youtube_url": "https://rr2---sn-h50gpup0nuxaxjvh-hg0d.googlevideo.com/videoplayback?expire=1761440010&ei=qhz9aPzpNZiG0u8Pu5vbwQ0&ip=102.115.16.96&id=o-ACVz-QJF_vMXbtgSceLgrOXyN2m8gHWla13jZdIwoTVU&itag=140&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1761418410%2C&mh=0r&mm=31%2C29&mn=sn-h50gpup0nuxaxjvh-hg0d%2Csn-woc7knes&ms=au%2Crdu&mv=m&mvi=2&pl=23&rms=au%2Cau&initcwndbps=1613750&bui=AdEuB5T0d4iaT_OIszCIDeBDwts9nhV-RI_utNSVmaJhvGjl92QOYADK069zqPeeJshUptUbI36nThdg&spc=6b0G_P-dLnQx&vprv=1&svpuc=1&mime=audio%2Fmp4&rqh=1&gir=yes&clen=3683045&dur=227.532&lmt=1710607756602288&mt=1761418186&fvip=4&keepalive=yes&fexp=51552689%2C51565116%2C51565681%2C51580968&c=ANDROID&txp=4532434&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRgIhALf8mhanQlRHqKCIB-K5clY7jemxHh6h9V5JOCtJoioHAiEA9YFNtYLT2E14EW4fSj4Vch8cImUg51rCRJBQjA0Y5bQ%3D&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=APaTxxMwRAIgEbsppIeWzymXpBQOnpFTmpxlve7JcFCbSLFqxNv9ClcCIFPOGDTtHFGCCw7o2ab-SOI3ozyfleF0BABgjuIGqkrc",
        "file_url": ""
      },
      {
        "disc_number": 0,
        "duration_ms": 229401,
        "explicit": true,
        "id": "91cde03a-681c-4daf-8bd8-1bb2c1ed033f",
        "name": "FRONTAL LOBE MUZIK (feat. Pharrell Williams)",
        "track_number": 4,
        "uri": "",
        "is_available": true,
        "youtube_url": "https://rr4---sn-h50gpup0nuxaxjvh-hg0k.googlevideo.com/videoplayback?expire=1761440011&ei=qxz9aL35JoOAp-oPrO_0mAU&ip=102.115.16.96&id=o-ADcvF5UZEHx3mpxvB-JsU8PxZu1EAHtdKegdOMCfxFRq&itag=140&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1761418411%2C&mh=TA&mm=31%2C29&mn=sn-h50gpup0nuxaxjvh-hg0k%2Csn-4g5edndd&ms=au%2Crdu&mv=m&mvi=4&pl=23&rms=au%2Cau&initcwndbps=1682500&bui=AdEuB5Qb_UkS_ZTn6iochmbfBtF8CiEztxTJbNRzL-QGlxxHKZ_KJOStFnicjGPwLvwAYf-8BetIOLOq&spc=6b0G_DeuGNLg&vprv=1&svpuc=1&mime=audio%2Fmp4&rqh=1&gir=yes&clen=3756763&dur=232.083&lmt=1709224375664404&mt=1761417950&fvip=1&keepalive=yes&fexp=51552689%2C51565115%2C51565682%2C51580968&c=ANDROID&txp=2218224&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRgIhAJ0KDqr8_z14QJJA6vSNCbW_rFO-iw41UCenUwqi6z03AiEA58kN6csLIPMdMHSWj4m6d_Azf8C3tMgmDVtG-w1yL4k%3D&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=APaTxxMwRgIhAIdut6JILvmjZXNcMQeeRH504ZB1tEtGRlZpAykRs2LXAiEAp4DyESCkrYvVrmNoUidey5Ew2iO83xxXBa0n-UWRrK4%3D",
        "file_url": ""
      }
    ];
    for(int i =0; i<ttracks.length; i++){
      tTracks.add(TrackData.fromJson(ttracks[i]));
    }
  }

  Future<void> playMusic(player) async{
    try{
      String streamUrl = "";
      // if (numberOfRetry == 0){
      //   streamUrl = "https://rr6---sn-h50gpup0nuxaxjvh-hg0k.googlevideo.com/videoplayback?expire=1760573267&ei=8-LvaIjwKP67vdIP_4TpuQ8&ip=102.115.2.163&id=o-AKa8A7wLavo9bOAIaOt4S1wqEvOQ2APaCHOsi0GW3K9b&itag=140&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1760551667%2C&mh=7O&mm=31%2C29&mn=sn-h50gpup0nuxaxjvh-hg0k%2Csn-woc7kn7r&ms=au%2Crdu&mv=m&mvi=6&pl=23&rms=au%2Cau&initcwndbps=1852500&bui=ATw7iSXeFBVGDywzSb8Of6TMPt2uFaBopcHMJDZrfxZqW2svAYn2ZPLeOk2iUVa_1Y4hmEfAFu5cMrNW&vprv=1&svpuc=1&mime=audio%2Fmp4&ns=Nz1NkK7ZHYe13shKwWEa6B4Q&rqh=1&gir=yes&clen=2989464&dur=184.645&lmt=1714512200039696&mt=1760551278&fvip=2&keepalive=yes&lmw=1&fexp=51557447%2C51565116%2C51565682%2C51580970&c=TVHTML5&sefc=1&txp=4432434&n=VyQgruI5f4Ce-Q&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=APaTxxMwRAIgM6Bcj6U6JZGyvqfG_JOSRQhI7ImGJ1wc6tsy15g6eZYCIA40s_LUGWv9O34yYO44CyxmsJjc4J7tmTjBPSao7HFD&sig=AJfQdSswRQIhAJbtJtwpyDHPDX5o7y6q_xImDKE940yBTov7ov3jWu4CAiAlLtvntD88DtK0592lrRMv0_Cy-ohxqU59DTV8uxy15w%3D%3D";
      // } else {
      //   print("=====retryyy");
      //   streamUrl = "https://rr4---sn-h50gpup0nuxaxjvh-hg0k.googlevideo.com/videoplayback?expire=1761349444&ei=5Lr7aJmNHrzdp-oPrrC-gAM&ip=102.115.47.222&id=o-AH66nhQcrmq_hpSwekedz0_j0vL0gDqDVZ-la9Gj99Y0&itag=251&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1761327844%2C&mh=ZE&mm=31%2C29&mn=sn-h50gpup0nuxaxjvh-hg0k%2Csn-4g5edn6y&ms=au%2Crdu&mv=m&mvi=4&pl=22&rms=au%2Cau&gcr=mu&initcwndbps=1563750&bui=AdEuB5R8q7yZuRW7l6WxsbexJNdF14ldM6ndxVlI2CBQXncSrcSfs2kUGGq2V3dHT_d-1e85O8fNTOoP&spc=6b0G_HBJepci&vprv=1&svpuc=1&mime=audio%2Fwebm&rqh=1&gir=yes&clen=3681447&dur=226.341&lmt=1761280345584330&mt=1761327423&fvip=5&keepalive=yes&fexp=51552689%2C51565116%2C51565682%2C51580968&c=ANDROID&txp=4432534&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cgcr%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRQIhAIsSK0LFCKOM7jNnMbYNiXpuGCQwmSd2tWT99t_TQNAEAiAuRHkM_wuvg9hrMsoXr0LyW_S2fZzdhjvKRC9qT66QWg%3D%3D&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=APaTxxMwRQIgcNdWEfQhHveJfemoYzmli3seS7wJp1C9cuD8yJPa3WUCIQCwiT31c_fjym1wrDYSdY1Rx1GRNzpRrO23jjOYPYqWjQ%3D%3D";
      // }
      streamUrl = "https://rr4---sn-h50gpup0nuxaxjvh-hg0k.googlevideo.com/videoplayback?expire=1761349444&ei=5Lr7aJmNHrzdp-oPrrC-gAM&ip=102.115.47.222&id=o-AH66nhQcrmq_hpSwekedz0_j0vL0gDqDVZ-la9Gj99Y0&itag=251&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1761327844%2C&mh=ZE&mm=31%2C29&mn=sn-h50gpup0nuxaxjvh-hg0k%2Csn-4g5edn6y&ms=au%2Crdu&mv=m&mvi=4&pl=22&rms=au%2Cau&gcr=mu&initcwndbps=1563750&bui=AdEuB5R8q7yZuRW7l6WxsbexJNdF14ldM6ndxVlI2CBQXncSrcSfs2kUGGq2V3dHT_d-1e85O8fNTOoP&spc=6b0G_HBJepci&vprv=1&svpuc=1&mime=audio%2Fwebm&rqh=1&gir=yes&clen=3681447&dur=226.341&lmt=1761280345584330&mt=1761327423&fvip=5&keepalive=yes&fexp=51552689%2C51565116%2C51565682%2C51580968&c=ANDROID&txp=4432534&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cgcr%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRQIhAIsSK0LFCKOM7jNnMbYNiXpuGCQwmSd2tWT99t_TQNAEAiAuRHkM_wuvg9hrMsoXr0LyW_S2fZzdhjvKRC9qT66QWg%3D%3D&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=APaTxxMwRQIgcNdWEfQhHveJfemoYzmli3seS7wJp1C9cuD8yJPa3WUCIQCwiT31c_fjym1wrDYSdY1Rx1GRNzpRrO23jjOYPYqWjQ%3D%3D";
      // final player = AudioPlayer();
      await player.setSourceUrl(streamUrl);
      await player.resume();
    } catch(e){
      if (numberOfRetry == 0) {
        print("we are replaying");
        numberOfRetry++;
        playMusic(player);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AlbumScreenHero(albumData: widget.albumData),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 56.0),
              child: FloatingActionButton.extended(
                  onPressed: ()async {
                    Provider.of<PlayerBrain>(context, listen: false).playAlbum(tTracks);
                    setState((){
                      isSongPlaying= !isSongPlaying;
                    });
        
                  },
                backgroundColor: Colors.white,
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

            IconButton(onPressed: (){
              Provider.of<PlayerBrain>(context, listen:false).next();
            }, icon: Icon(Icons.skip_next)),
            IconButton(onPressed: (){
              Provider.of<PlayerBrain>(context, listen:false).pauseCurrentlyPlayedTrack();
            }, icon: Icon(Icons.pause_circle_filled)),
            IconButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context){return PlayerScreen();}
                )
              );
            }, icon: Icon(Icons.ac_unit_rounded)),
            AlbumTitleItem(),
            AlbumTitleItem(),
            AlbumTitleItem(),
            AlbumTitleItem(),
            AlbumTitleItem(),
            AlbumTitleItem(),
            AlbumTitleItem(),
            AlbumTitleItem(),
            AlbumTitleItem(),
            AlbumTitleItem(),
          ],
        ),
      ),
    );
  }


}


