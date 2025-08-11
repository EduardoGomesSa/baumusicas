import 'package:baumusicas/src/pages/base_page.dart';
import 'package:baumusicas/src/pages/home/home_page.dart';
import 'package:baumusicas/src/pages/playlist/playlist_page.dart';
import 'package:baumusicas/src/pages/splash_page.dart';
import 'package:get/get.dart';

abstract class AppRoute {
  static final pages = <GetPage>[
    GetPage(
      name: PageRoutes.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: PageRoutes.playlist,
      page: () => const PlaylistPage(),
    ),
    GetPage(
      name: PageRoutes.base,
      page: () => const BasePage(),
    ),
    GetPage(
      name: '/spash',
      page: () => const SplashPage(),
    ),
  ];
}

abstract class PageRoutes {
  static const String home = '/home';
  static const String playlist = '/playlist';
  static const String base = '/';
  static const String splash = '/splash';
}
