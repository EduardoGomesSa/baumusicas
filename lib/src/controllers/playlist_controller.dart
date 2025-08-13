import 'package:baumusicas/src/models/playlist_model.dart';
import 'package:baumusicas/src/repositories/playlist_repository.dart';
import 'package:get/get.dart';

class PlaylistController extends GetxController {
  final PlaylistRepository repository = PlaylistRepository();

  @override
  void onInit() {
    super.onInit();

    getPlaylists();
  }

  Rx<PlaylistModel> playlistModel = PlaylistModel().obs;
  RxList<PlaylistModel> listPlaylists = RxList<PlaylistModel>([]);
  var isLoading = false.obs;

  void create() async {
    await repository.create(playlistModel.value);
  }

  Future getPlaylists() async {
    isLoading.value = true;

    List<PlaylistModel> list = await repository.get();

    isLoading.value = false;

    listPlaylists.assignAll(list);

    return list;
  }
}
