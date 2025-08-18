import 'package:baumusicas/src/repositories/music_repository.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicController extends GetxController {
  final MusicRepository _repository = MusicRepository();
  final player = AudioPlayer();

  var musics = <SongModel>[].obs;
  var isLoading = false.obs;
  var currentSong = Rxn<SongModel>();
  var isPlaying = false.obs;
  var isPaused = false.obs;
  RxInt currentIndex = 0.obs;
  var position = Duration.zero.obs;
  var duration = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();

    getMusics();

    player.playingStream.listen((isPlayingNow) {
      isPlaying.value = isPlayingNow;
      isPaused.value = !isPlayingNow;
    });

    player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        isPlaying.value = false;
        isPaused.value = false;
      }
    });

    player.playerStateStream.listen((state) {
      if (!state.playing && state.processingState == ProcessingState.idle) {
        stopMusic();
      }
    });

    player.durationStream.listen((dur) {
      duration.value = dur ?? Duration.zero;
    });

    player.positionStream.listen((pos) {
      position.value = pos;
    });
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

    if (isPaused.value) {
      isPlaying.value = true;
      isPaused.value = false;
      await player.play();
      return;
    }

    final song = musics[index];

    try {
      isPlaying.value = true;
      isPaused.value = false;
      currentSong.value = song;
      currentIndex.value = index;
      final playlistSource = ConcatenatingAudioSource(
        children: musics.map((s) {
          return AudioSource.uri(
            Uri.parse(s.uri!),
            tag: MediaItem(
              id: s.id.toString(),
              album: s.album,
              title: s.title,
              artUri: Uri.parse(s.uri!),
            ),
          );
        }).toList(),
      );

      await player.setAudioSource(playlistSource, initialIndex: index);
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
      playMusic(0);
    }
  }

  void previousMusic() {
    final prevIndex = currentIndex.value - 1;
    if (prevIndex >= 0) {
      playMusic(prevIndex);
    } else {
      playMusic(musics.length - 1);
    }
  }

  void pauseMusic() {
    isPlaying.value = false;
    isPaused.value = true;
    player.pause();
  }

  void stopMusic() {
    isPlaying.value = false;
    isPaused.value = false;
    currentSong.value = null;
    player.stop();
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
