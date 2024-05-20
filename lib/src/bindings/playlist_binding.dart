import 'package:baumusicas/src/controllers/playlist_controller.dart';
import 'package:get/get.dart';

class PlaylistBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(PlaylistController());
  }
}