import 'package:baumusicas/src/repositories/music_repository.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicController extends GetxController {
  final MusicRepository _repository = MusicRepository();
  final player = AudioPlayer();

  var musics = <SongModel>[].obs;
  var isLoading = false.obs;
  var currentSong = Rxn<SongModel>();

  @override
  void onInit() {
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

  Future<void> playMusic(SongModel song) async {
    try {
      await player.setAudioSource(AudioSource.uri(Uri.parse(song.uri!)));
      await player.play();
      currentSong.value = song;
    } catch (e) {
      print("Erro ao reproduzir: $e");
    }
  }

  void pauseMusic() {
    player.pause();
  }

  void stopMusic() {
    player.stop();
    currentSong.value = null;
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
