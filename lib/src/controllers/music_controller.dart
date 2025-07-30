import 'package:baumusicas/src/repositories/music_repository.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicController extends GetxController {
  final MusicRepository _repository = MusicRepository();

  var musics = <SongModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit(){
    super.onInit();

    getMusics();
  }

  Future<void> getMusics() async {
    isLoading.value = true;

    try {
      final result = await _repository.getAllMusics();
      musics.value = result;
    } catch (e) {
      print("Erro ao buscar músicas: $e");
    } finally {
      isLoading.value = false;
    }
  }
}