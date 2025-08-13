import 'package:baumusicas/src/database/db.dart';
import 'package:baumusicas/src/models/playlist_model.dart';
import 'package:sqflite/sqflite.dart';

class PlaylistRepository {
  Future<bool> create(PlaylistModel model) async {
    final db = await Db.connection();

    var playlistId = await db.insert(
      'playlists',
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (model.musics != null && model.musics!.isNotEmpty) {
      for (var music in model.musics!) {
        await db.insert(
          'musics',
          {
            'title': music.name,
            'artist': music.address,
            'playlist_id': playlistId,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    return playlistId > 0;
  }

  Future<List<PlaylistModel>> get() async {
    final db = await Db.connection();

    final result = await db.query('playlists');

    List<PlaylistModel> list;

    list = PlaylistModel.fromList(result);

    return Future.value(list);
  }
}
