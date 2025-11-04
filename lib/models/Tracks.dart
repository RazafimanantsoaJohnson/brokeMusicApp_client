

class TrackData{
  late int discNumber;
  late int duration;
  late String id;
  late String name;
  late int trackNumber;
  late bool explicit;
  late String trackUri;
  late bool isAvailable;
  late String youtubeUrl;
  late String fileURL;

  TrackData({required this.discNumber, required this.duration, required this.name, required this.id, required this.trackNumber,
    this.trackUri = "", this.explicit = false, this.isAvailable= true, this.youtubeUrl= "", this.fileURL= "" });

  TrackData.fromJson(dynamic track){
    discNumber = track["disc_number"];
    duration = track["duration_ms"];
    explicit = track["explicit"];
    id = track["id"];
    name = track["name"];
    trackNumber = track["track_number"];
    if (track["youtube_url"] != null){
      youtubeUrl = track["youtube_url"];
      fileURL = track["file_url"];
    }
  }
}