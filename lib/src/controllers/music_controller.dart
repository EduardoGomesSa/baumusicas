import 'dart:async';

import 'package:baumusicas/src/repositories/music_repository.dart';
import 'package:flutter/material.dart';
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
  bool _isUpdating = false;
  StreamSubscription<bool>? _playingStreamSubscription;

  @override
  void onInit() {
    super.onInit();

    getMusics();

    setupPlayerListener();

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

  Future<void> playMusic(int index, BuildContext context) async {
    if (index < 0 || index >= musics.length) return;
    _isUpdating = true;
    if (isPaused.value) {
      isPlaying.value = true;
      isPaused.value = false;
      await player.play();
      _isUpdating = false;
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
    } finally {
      _isUpdating = false;
      // Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context) => MusicPage(index: index)));
    }
  }

  void nextMusic(BuildContext context) {
    int nextIndex = currentIndex.value + 1;
    if (nextIndex < musics.length) {
      playMusic(nextIndex, context);
    } else {
      playMusic(0, context);
    }
  }

  void previousMusic(BuildContext context) {
    final prevIndex = currentIndex.value - 1;
    if (prevIndex >= 0) {
      playMusic(prevIndex, context);
    } else {
      playMusic(musics.length - 1, context);
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

  void setupPlayerListener() {
    _playingStreamSubscription = player.playingStream.listen((isPlayingNow) {
      if (!_isUpdating) {
        var playing = isPlaying.value;
        isPlaying.value = isPlayingNow;
        isPaused.value = playing ? !isPlayingNow : isPlayingNow;
        print(
            "Listener atualizado: isPlaying = $isPlayingNow, isPaused = ${!isPlayingNow}");
      }
    });
  }

  @override
  void onClose() {
    _playingStreamSubscription?.cancel();
    player.dispose();
    super.onClose();
  }
}
