import 'package:crypto_app/models/api_response.dart';
import 'package:crypto_app/models/coin_data.dart';
import 'package:crypto_app/models/tracked_asset.dart';
import 'package:crypto_app/services/http_services.dart';
import 'package:get/get.dart';

class AssetsController extends GetxController {
  RxList<TrackedAsset> trackedAssets = <TrackedAsset>[].obs;
  RxBool loading = false.obs;
  RxList<CoinData> coinData = <CoinData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAssets();
  }

  // get assets

  Future<void> getAssets() async {
    try {
      HttpServices httpServices = Get.find();

      var responseData = await httpServices.get('currencies');

      CurrenciesListAPIResponse currenciesListAPIResponse =
          CurrenciesListAPIResponse.fromJson(responseData!);
      coinData.value = currenciesListAPIResponse.data!;
    } catch (e) {
      throw e.toString();
    }
  }

  void addTrackedAsset(String name, double amount) {
    trackedAssets.add(
      TrackedAsset(
        name: name,
        amount: amount,
      ),
    );
  }

  // get conin data

  CoinData? getCoinData(String name) {
    return coinData.firstWhereOrNull((coin) => coin.name == name);
  }

  // get coin price

  double getCoinPrice(String name) {
    CoinData data = getCoinData(name)!;
    return data.values?.uSD?.price?.toDouble() ?? 0;
  }

  // get portfolio value

  double getPortfolioValue() {
    if (trackedAssets.isEmpty) {
      return 0;
    }
    if (coinData.isEmpty) {
      return 0;
    }

    double value = 0;

    for (TrackedAsset asset in trackedAssets) {
      value += getCoinPrice(asset.name!) * asset.amount!;
    }
    return value;
  }
}
