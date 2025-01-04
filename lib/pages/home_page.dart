import 'package:crypto_app/components/assets_dialog.dart';
import 'package:crypto_app/controllers/assets_controller.dart';
import 'package:crypto_app/models/tracked_asset.dart';
import 'package:crypto_app/pages/coin_page.dart';
import 'package:crypto_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final AssetsController assetsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: const CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=6'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(
                AssetsDialog(),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '\$ ',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          assetsController.getPortfolioValue().toStringAsFixed(
                                2,
                              ),
                          style: const TextStyle(fontSize: 35),
                        ),
                      ],
                    ),
                    const Text(
                      'Portfolio Value',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Portfolio',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: ListView.builder(
                  itemCount: assetsController.trackedAssets.length,
                  itemBuilder: (BuildContext context, int index) {
                    TrackedAsset trackedAsset =
                        assetsController.trackedAssets[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          CoinPage(
                            trackedAsset: trackedAsset,
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(trackedAsset.name!),
                        subtitle: Text(
                          assetsController
                              .getCoinPrice(trackedAsset.name!)
                              .toStringAsFixed(
                                2,
                              ),
                        ),
                        leading: Image(
                          image: NetworkImage(
                            getCryptoUrl(
                              trackedAsset.name!,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
