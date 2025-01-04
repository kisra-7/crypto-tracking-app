import 'package:crypto_app/components/my_button.dart';
import 'package:crypto_app/controllers/assets_controller.dart';
import 'package:crypto_app/controllers/assets_dialog_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetsDialog extends StatelessWidget {
  AssetsDialog({super.key});
  final controller = Get.put(AssetsDialogController());
  final AssetsController assetsController = Get.find();
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Material(
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.80,
              height: MediaQuery.sizeOf(context).height * 0.40,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: controller.loading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownButton(
                              value: controller.selectedAsset.value,
                              items: controller.assets.map((asset) {
                                return DropdownMenuItem(
                                    value: asset, child: Text(asset));
                              }).toList(),
                              onChanged: (val) {
                                controller.selectedAsset.value = val!;
                              }),
                          TextField(
                            controller: textController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'Please enter the a mount',
                                border: OutlineInputBorder()),
                          ),
                          MyButton(
                            text: 'Enter Amount',
                            onTap: () {
                              assetsController.addTrackedAsset(
                                controller.selectedAsset.value,
                                double.parse(
                                  textController.text,
                                ),
                              );

                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
