import 'package:get/get.dart';
import 'package:movie_list_zul/app/modules/first_screen/controllers/first_screen_controller.dart';
import 'package:movie_list_zul/app/modules/home/controllers/home_controller.dart';
import 'package:movie_list_zul/app/services/tmdb_services.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Bind your controllers or services here
    Get.lazyPut<FirstScreenController>(() => FirstScreenController());

    Get.lazyPut<HomeController>(() => HomeController(Get.put(TmdbService())));

    // Add other dependencies as needed
  }
}
