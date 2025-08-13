import 'package:baumusicas/src/database/db.dart';
import 'package:baumusicas/src/models/playlist_model.dart';
import 'package:sqflite/sqflite.dart';

class PlaylistRepository {
  Future<bool> insert(PlaylistModel model) async {
    final db = await Db.connection();

    var result = await db.insert(
      'playlists',
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result > 0;
  }

  Future<List<PlaylistModel>> get() async {
    final db = await Db.connection();

    final result = await db.query('playlists');

    List<PlaylistModel> list;

    list = PlaylistModel.fromList(result);

    return Future.value(list);
  }
}
