import 'package:baumusicas/src/models/playlist_model.dart';

class MusicModel {
  int? id;
  String? name;
  String? address;
  PlaylistModel? playlist;

  MusicModel({
    this.id,
    this.name,
    this.address,
    this.playlist,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'playlist_id': playlist?.id,
    };
  }

  factory MusicModel.fromMap(Map<String, dynamic> map) {
    return MusicModel(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      playlist:
          map['playlist'] != null ? PlaylistModel.fromMap(map['playlist']) : null,
    );
  }

  fromList(list) {
    return List<MusicModel>.from(list.map((x) => MusicModel.fromMap(x)));
  }
}
