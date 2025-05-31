import 'package:baumusicas/src/controllers/playlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final PlaylistController playlistController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todas as Músicas'),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          playlistController.getPlaylists();
        },
        child: playlistController.listPlaylists.isNotEmpty
            ? ListView.builder(
                itemCount: playlistController.listPlaylists.length,
                itemBuilder: (ctx, index) => Text(
                    'nome da playlist: ${playlistController.listPlaylists[index].name}'),
              )
            : const Text('Nenhuma playlist criada'),
      ),
    );
  }
}
