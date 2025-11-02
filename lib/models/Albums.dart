

class AlbumData {
  late String id;
  late String name;
  late String albumType;
  late int totalTracks;
  late String releaseDate;
  late String releaseDatePrecision;
  late String type;
  late String artistName;
  late String albumCoverUrl;

  AlbumData({required this.id, required this.name, required this.albumType, required this.totalTracks,required this.releaseDate,
    required this.releaseDatePrecision, required this.type, required this.artistName, required this.albumCoverUrl});

  AlbumData.fromJson(dynamic album){
    id = album["id"];
    name = album["name"];
    albumType = album["album_type"];
    totalTracks = album["total_tracks"];
    releaseDate = album["release_date"];
    releaseDatePrecision = album["release_date_precision"];
    type = album["type"];
    artistName = album["artist"];
    albumCoverUrl = album["album_cover"];
  }
  AlbumData.fromRecentlyVisitedJson(dynamic album){
    id = album["album_id"];
    name = album["album_name"];
    artistName = album["artist"];
    albumCoverUrl = album["album_cover_url"];
    releaseDate = album["release_date"];
    totalTracks = album["number_of_tracks"];
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