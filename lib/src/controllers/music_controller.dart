import 'package:baumusicas/src/models/playlist_model.dart';
import 'package:baumusicas/src/repositories/playlist_repository.dart';

class MusicController {
  final PlaylistRepository repository = PlaylistRepository();

  final playlistModel = PlaylistModel(id: 1, name: 'Rap Geek');

  void create(){
    repository.insert(playlistModel);
  }
}