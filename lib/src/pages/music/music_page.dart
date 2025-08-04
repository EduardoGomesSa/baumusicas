import 'package:baumusicas/src/controllers/music_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key, required this.model});

  final SongModel model;

  @override
  Widget build(BuildContext context) {
    final MusicController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da música"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Colors.red,
              child: Text("Imagem"),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.title),
              Text(model.artist ?? "Artista Desconhecido"),
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
                              : controller.playMusic(model);
                        },
                        icon: Icon(
                          controller.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 50,
                        )),
                  ),
                  IconButton(
                      onPressed: () {},
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
      ),
    );
  }
}
