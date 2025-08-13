import 'package:baumusicas/src/models/music_model.dart';

class PlaylistModel {
  int? id;
  String? name;
  List<MusicModel>? musics = [];

  PlaylistModel({
    this.id,
    this.name,
    this.musics,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'musics': musics?.map((e) => e.toMap()).toList(),
    };
  }

  factory PlaylistModel.fromMap(Map<String, dynamic> map) {
    return PlaylistModel(
      id: map['id'],
      name: map['name'],
      musics: map['musics'] != null
          ? List<MusicModel>.from(
              map['musics']?.map((x) => MusicModel.fromMap(x)))
          : [],
    );
  }

  static List<PlaylistModel> fromList(list) {
    return List<PlaylistModel>.from(list.map((x) => PlaylistModel.fromMap(x)));
  }
}
