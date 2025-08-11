import 'package:baumusicas/src/controllers/playlist_controller.dart';
import 'package:baumusicas/src/pages/playlist/playlist_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    final PlaylistController controller = Get.put(PlaylistController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suas Playlists'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.listPlaylists.isEmpty) {
          return const Center(child: Text("Nenhuma playlist encontrada."));
        }
        return ListView.builder(
          itemCount: controller.listPlaylists.length,
          itemBuilder: (context, index) {
            final playlist = controller.listPlaylists[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.playlist_play),
                title: Text(playlist.name),
                trailing: const Text("Total de músicas: 10"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PlaylistDetailPage(),
                    ),
                  );
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
