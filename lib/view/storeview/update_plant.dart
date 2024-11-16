import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gardenia/controller/store_controller.dart/gardenia_store_controller.dart';
import 'package:get/get.dart';
import '../../commonWidget/customTextField.dart';
import '../../commonWidget/primareButton.dart';
import '../../theme.dart';

class UpdatePlant extends StatelessWidget {
  UpdatePlant({super.key, required this.productImage, required this.productId});

  final String productImage;
  final String productId;
  final GardeniaStoreController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColor.background,
          foregroundColor: ThemeColor.blackColor,
          title: const Text(
            'Edit Plant',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Obx(
              () => controller.loadingEdit.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        InkWell(
                          child: Container(
                            width: size.width * 0.4,
                            height: size.height * 0.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: controller.editImage.value.isEmpty
                                        ? NetworkImage(productImage)
                                        : FileImage(
                                            File(controller.editImage.value))),
                                borderRadius: BorderRadius.circular(80)),
                          ),
                          onTap: () {
                            controller.uploadeditphoto();
                          },
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            "Enter the updated information",
                            style: TextStyle(
                                color: ThemeColor.blackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        CustomTextFieldWithoutIcon(
                          title: "Plant name",
                          onIconPressed: () {},
                          controller: controller.editPlantName,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                        const SizedBox(height: 30),
                        CustomTextFieldWithoutIcon(
                          title: "Plant Category",
                          onIconPressed: () {},
                          controller: controller.editCategory,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                        const SizedBox(height: 30),
                        CustomTextFieldWithoutIcon(
                          title: "Plant Price",
                          onIconPressed: () {},
                          controller: controller.editPrice,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                        ),
                        const SizedBox(height: 30),
                        CustomTextFieldWithoutIcon(
                          // icon: Icon(Icons.emoji_emotions),
                          title: "Plant Description",
                          onIconPressed: () {},
                          controller: controller.editDesc,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                        const SizedBox(height: 30),
                        PrimaryButton(
                          text: "Edit",
                          height: 50,
                          width: 130,
                          onTap: () {
                            controller.updateProduct(productImage, productId);
                          },
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
