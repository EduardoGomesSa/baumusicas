import 'package:baumusicas/src/models/playlist_model.dart';
import 'package:baumusicas/src/repositories/playlist_repository.dart';
import 'package:get/get.dart';

class PlaylistController extends GetxController {
  final PlaylistRepository repository = PlaylistRepository();

  @override
  void onInit(){
    super.onInit();

    create();

    getPlaylists();
  }

  final playlistModel = PlaylistModel(id: 2, name: 'Rap Geek');
  RxList<PlaylistModel> listPlaylists = RxList<PlaylistModel>([]);

  void create() async {
    await repository.insert(playlistModel);
  }

  Future getPlaylists() async {
    List<PlaylistModel> list = await repository.get();

    listPlaylists.assignAll(list);

    return list;
  }
}