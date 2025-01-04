import 'package:crypto_app/controllers/assets_controller.dart';
import 'package:crypto_app/services/http_services.dart';
import 'package:get/get.dart';

Future<void> registreServices() async {
  Get.put(HttpServices());
}

Future<void> registreController() async {
  Get.put(AssetsController());
}

String getCryptoUrl(String name) {
  return 'https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/master/128/${name.toLowerCase()}.png';
}
