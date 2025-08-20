import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicRepository {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<SongModel>> getAllMusics() async {
    var permission = await Permission.audio.request();

    if (!permission.isGranted) {
      throw Exception("Permissão negada para acessar arquivos de áudio.");
    }

    List<SongModel> songs = await _audioQuery.querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    return songs.where((song) => (song.duration ?? 0) > 140000).toList();
  }

  Future<SongModel> getByPath(String path) async {
    var permission = await Permission.audio.request();

    if (!permission.isGranted) {
      throw Exception("Permissão negada para acessar arquivos de áudio.");
    }

    List<SongModel> songs = await _audioQuery.querySongs(
        uriType: UriType.EXTERNAL, ignoreCase: true, path: path);

    return songs.isNotEmpty
        ? Future.value(songs.first)
        : Future.error("Música não encontrada");
  }

  // getAllByPath(String path) async {
  //   var permission = await Permission.audio.request();

  //   if (!permission.isGranted) {
  //     throw Exception("Permissão negada para acessar arquivos de áudio.");
  //   }

  //   List<SongModel> songs = await _audioQuery.querySongs(
  //       uriType: UriType.EXTERNAL, ignoreCase: true, path: path);

  //   return Future.value(songs);
  // }
}
