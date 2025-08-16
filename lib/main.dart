import 'package:baumusicas/src/bindings/music_binding.dart';
import 'package:baumusicas/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Baum Musicas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: false,
          bottomAppBarTheme: const BottomAppBarTheme(color: Colors.blue)),
      initialBinding: MusicBinding(),
      initialRoute: PageRoutes.splash,
      getPages: AppRoute.pages,
    );
  }
}
