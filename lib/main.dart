import 'package:baumusicas/src/bindings/playlist_binding.dart';
import 'package:baumusicas/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Baum Musicas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: false,
          bottomAppBarTheme: const BottomAppBarTheme(color: Colors.blue)),
      initialBinding: PlaylistBinding(),
      initialRoute: PageRoutes.base,
      getPages: AppRoute.pages,
    );
  }
}
