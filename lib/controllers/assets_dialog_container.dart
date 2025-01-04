import 'package:crypto_app/models/api_response.dart';
import 'package:crypto_app/services/http_services.dart';
import 'package:get/get.dart';

class AssetsDialogController extends GetxController {
  RxBool loading = false.obs;
  RxString selectedAsset = ''.obs;
  RxList<String> assets = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAssets();
  }

  Future<void> getAssets() async {
    loading.value = true;
    HttpServices httpServices = Get.find();
    final responseData = await httpServices.get('currencies');

    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responseData);

    currenciesListAPIResponse.data?.forEach((coin) {
      assets.add(coin.name!);
    });

    selectedAsset.value = assets.first;
    loading.value = false;
  }
}
