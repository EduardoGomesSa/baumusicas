import 'package:baumusicas/src/controllers/music_controller.dart';
import 'package:baumusicas/src/controllers/playlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
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
            );
          },
        );
      }),
    );
  }
}
