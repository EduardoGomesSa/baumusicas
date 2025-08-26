import 'package:baumusicas/src/controllers/music_controller.dart';
import 'package:baumusicas/src/pages/music/music_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final MusicController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todas as Músicas'),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.musics.isEmpty) {
            return const Center(child: Text("Nenhuma música encontrada."));
          }
          return ListView.builder(
            itemCount: controller.musics.length,
            itemBuilder: (context, index) {
              final song = controller.musics[index];
              return GestureDetector(
                onTap: () async {
                  await controller.playMusic(index, context);
                  
                  if (controller.isPlaying.value &&
                      controller.currentIndex.value == index) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            MusicPage(index: index, homeContext: context)));
                  }
                },
                child: ListTile(
                    title: Text(song.title),
                    subtitle: Text(song.artist ?? "Artista desconhecido"),
                    trailing: Obx(() => IconButton(
                          icon: Icon(controller.isPlaying.value &&
                                  controller.currentSong.value == song
                              ? Icons.pause
                              : Icons.play_arrow),
                          onPressed: () async => controller.isPlaying.value &&
                                  controller.currentIndex.value == index
                              ? controller.pauseMusic()
                              : await controller.playMusic(index, context),
                        ))),
              );
            },
          );
        }),
        bottomNavigationBar: Obx(() {
          final song = controller.currentSong.value;
          final pos = controller.position.value;
          final dur = controller.duration.value;
          if (song == null) return const SizedBox.shrink();

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MusicPage(
                        index: controller.currentIndex.value,
                        homeContext: context,
                      )));
            },
            child: SizedBox(
              width: double.infinity,
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    dense: true,
                    title: Text(song.title),
                    subtitle: Text(song.artist ?? ""),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: controller.pauseMusic,
                          icon: Icon(controller.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow),
                        ),
                        controller.isPlaying.value
                            ? const SizedBox.shrink()
                            : IconButton(
                                onPressed: controller.stopMusic,
                                icon: const Icon(Icons.stop),
                              )
                      ],
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbShape: SliderComponentShape.noThumb,
                      trackHeight: 1.0,
                    ),
                    child: Slider(
                      min: 0.0,
                      max: dur.inMilliseconds.toDouble(),
                      value: pos.inMilliseconds.toDouble(),
                      onChanged: (value) {},
                      allowedInteraction: SliderInteraction.slideOnly,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
