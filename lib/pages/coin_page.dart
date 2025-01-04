import 'package:crypto_app/components/my_card.dart';
import 'package:crypto_app/controllers/assets_controller.dart';
import 'package:crypto_app/models/coin_data.dart';
import 'package:crypto_app/models/tracked_asset.dart';
import 'package:crypto_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CoinPage extends StatelessWidget {
  final TrackedAsset trackedAsset;
  CoinPage({super.key, required this.trackedAsset});
  AssetsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final CoinData coinData = controller.getCoinData(trackedAsset.name!)!;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: Text(trackedAsset.name!),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image(
                  width: 75,
                  image: NetworkImage(
                    getCryptoUrl(
                      trackedAsset.name!,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Text('\$ '),
                        Text(
                          (coinData.values?.uSD?.price!.toStringAsFixed(2))!,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Text(
                      coinData.values!.uSD!.percentChange24h.toString(),
                      style:
                          TextStyle(color: Colors.red.shade900, fontSize: 20),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                ),
                children: [
                  MyCard(
                    title: 'Circulating Supply',
                    subTitle: coinData.circulatingSupply.toString(),
                  ),
                  MyCard(
                    title: 'Max Supply',
                    subTitle: coinData.maxSupply.toString(),
                  ),
                  MyCard(
                    title: 'volume24hBase',
                    subTitle: coinData.volume24hBase!.toStringAsFixed(2),
                  ),
                  MyCard(
                    title: 'Rank',
                    subTitle: coinData.rank.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
