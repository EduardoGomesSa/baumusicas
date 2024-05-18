import 'package:baumusicas/src/bindings/playlist_binding.dart';
import 'package:baumusicas/src/pages/base_page.dart';
import 'package:baumusicas/src/pages/home/home_page.dart';
import 'package:baumusicas/src/pages/playlist/playlist_page.dart';
import 'package:get/get.dart';

abstract class AppRoute {
  static final pages = <GetPage>[
    GetPage(
      name: PageRoutes.home,
      page: () => HomePage(),
      bindings: [
        PlaylistBinding(),
      ]
    ),
    GetPage(
      name: PageRoutes.playlist,
      page: () => const PlaylistPage(),
    ),
    GetPage(
      name: PageRoutes.base,
      page: () => const BasePage(),
    ),
  ];
}

abstract class PageRoutes {
  static const String home = '/home';
  static const String playlist = '/playlist';
  static const String base = '/';
}
