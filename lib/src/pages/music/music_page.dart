import 'package:baumusicas/src/controllers/music_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_visualizer/music_visualizer.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key, required this.index});

  final int index;

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
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

        if (!mounted) return const SizedBox.shrink();
        if (song == null) {
          return const Center(
            child: Text("Erro ao carregar música"),
          );
        }

        final durationMusic = Duration(milliseconds: song.duration ?? 0);

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
                Column(
                  children: [
                    Obx(() {
                      final pos = controller.position.value;
                      final dur = controller.duration.value;

                      if (!mounted) return const SizedBox.shrink();
                      return Slider(
                        min: 0.0,
                        max: dur.inMilliseconds.toDouble(),
                        value: pos.inMilliseconds.toDouble(),
                        onChanged: (value) {},
                        onChangeEnd: (value) {
                          controller.player
                              .seek(Duration(milliseconds: value.toInt()));
                        },
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Obx(() => Text(
                              "${controller.position.value.inMinutes}:"
                              "${(controller.position.value.inSeconds % 60).toString().padLeft(2, '0')}")),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text("${(durationMusic.inMinutes)}:"
                              "${(durationMusic.inSeconds % 60).toString().padLeft(2, '0')}"),
                        ),
                      ],
                    )
                  ],
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
                    Obx(() {
                      if (!mounted) return const SizedBox.shrink();
                      return IconButton(
                          onPressed: () {
                            controller.isPlaying.value
                                ? controller.pauseMusic()
                                : controller.playMusic(widget.index);
                          },
                          icon: Icon(
                            controller.isPlaying.value
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 50,
                          ));
                    }),
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

  @override
  void dispose() {
    super.dispose();
  }
}
