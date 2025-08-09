import 'package:baumusicas/src/controllers/music_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_visualizer/music_visualizer.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.red[900]!,
      Colors.green[900]!,
      Colors.blue[900]!,
      Colors.brown[900]!
    ];

    final List<int> duration = [900, 700, 600, 800, 500];
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
              child: Center(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Card(
                    child: MusicVisualizer(
                      barCount: 30,
                      colors: colors,
                      duration: duration,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 5, left: 10),
                  child: Text(
                    song.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 15),
                  child: Text(song.artist ?? "Artista Desconhecido"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.previousMusic();
                        },
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
