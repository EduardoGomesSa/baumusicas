import 'package:baumusicas/src/controllers/music_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final MusicController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da música"),
      ),
      body: Obx(() {
        final song = controller.currentSong.value;

        if (song == null) {
          return const Center(
            child: Text("Erro ao carregar música"),
          );
        }

        return Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Colors.red,
                child: const Text("Imagem"),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(song!.title),
                Text(song.artist ?? "Artista Desconhecido"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          size: 50,
                        )),
                    Obx(
                      () => IconButton(
                          onPressed: () {
                            controller.isPlaying.value
                                ? controller.pauseMusic()
                                : controller.playMusic(index);
                          },
                          icon: Icon(
                            controller.isPlaying.value
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 50,
                          )),
                    ),
                    IconButton(
                        onPressed: () {
                          controller.nextMusic();
                        },
                        icon: const Icon(
                          Icons.skip_next_rounded,
                          size: 50,
                        )),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20)
          ],
        );
      }),
    );
  }
}
