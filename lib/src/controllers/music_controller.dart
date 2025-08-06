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
  var isPlaying = false.obs;
  RxInt currentIndex = 0.obs;

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

  Future<void> playMusic(int index) async {
    if (index < 0 || index >= musics.length) return;

    final song = musics[index];

    try {
      isPlaying.value = !isPlaying.value;
      currentSong.value = song;
      currentIndex.value = index;
      await player.setAudioSource(AudioSource.uri(Uri.parse(song.uri!)));
      await player.play();
    } catch (e) {
      print("Erro ao reproduzir: $e");
    }
  }

  void nextMusic() {
    int nextIndex = currentIndex.value + 1;
    if (nextIndex < musics.length) {
      playMusic(nextIndex);
    } else {
      print("Última música já está tocando.");
    }
  }

  void previousMusic() {
    final prevIndex = currentIndex.value - 1;
    if (prevIndex >= 0) {
      playMusic(prevIndex);
    } else {
      print("Primeira música já está tocando");
    }
  }

  void pauseMusic() {
    isPlaying.value = !isPlaying.value;
    player.pause();
  }

  void stopMusic() {
    isPlaying.value = !isPlaying.value;
    currentSong.value = null;
    player.stop();
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
