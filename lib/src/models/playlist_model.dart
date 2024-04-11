import 'package:baumusicas/src/models/music_model.dart';

class PlaylistModel {
  int? id;
  String? name;
  List<MusicModel>? musics;

  PlaylistModel({
    this.id,
    this.name,
    this.musics,
  });
}
