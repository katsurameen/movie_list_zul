import 'package:get/get.dart';
import 'package:movie_list_zul/app_bindings.dart';

import '../modules/first_screen/views/first_screen_view.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.FIRST_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: AppBindings(),
    ),
    GetPage(
      name: _Paths.FIRST_SCREEN,
      page: () => const FirstScreenView(),
      binding: AppBindings(),
    ),
  ];
}
