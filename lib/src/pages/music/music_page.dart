import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key, required this.model});

  final SongModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da música"),
      ),
      body: Center(child: Text(model.title),),
    );
  }
}