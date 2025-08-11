import 'package:flutter/material.dart';

class PlaylistDetailPage extends StatelessWidget {
  const PlaylistDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Playlist'),
      ),
      body: const Center(
        child: Text('Detalhes da playlist serão exibidos aqui.'),
      ),
    );
  }
}