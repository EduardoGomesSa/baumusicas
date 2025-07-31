import 'package:baumusicas/src/controllers/music_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final MusicController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return ListTile(
              title: Text(song.title),
              subtitle: Text(song.artist ?? "Artista desconhecido"),
              trailing: IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () => controller.playMusic(song),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        final song = controller.currentSong.value;
        if (song == null) return const SizedBox.shrink();

        return ListTile(
          title: Text(song.title),
          subtitle: Text(song.artist ?? ""),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: controller.pauseMusic,
                icon: const Icon(Icons.pause),
              ),
              IconButton(
                onPressed: controller.stopMusic,
                icon: const Icon(Icons.stop),
              ),
            ],
          ),
        );
      }),
    );
  }
}
