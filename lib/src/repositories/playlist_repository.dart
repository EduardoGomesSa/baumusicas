import 'package:baumusicas/src/database/db.dart';
import 'package:baumusicas/src/models/playlist_model.dart';
import 'package:sqflite/sqflite.dart';

class PlaylistRepository {
  Future<void> insert(PlaylistModel model) async {
    final db = await Db.connection();

    await db.insert(
      'playlists',
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PlaylistModel>> get() async {
    final db = await Db.connection();

    final result = await db.query('playlists');

    List<PlaylistModel> list;

    list = PlaylistModel.fromList(result);

    return Future.value(list);
  }
}
