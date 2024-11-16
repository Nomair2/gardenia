import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gardenia/controller/store_controller.dart/gardenia_store_controller.dart';
import 'package:gardenia/function/validinput.dart';
import 'package:get/get.dart';
import '../../commonWidget/customTextField.dart';
import '../../commonWidget/primareButton.dart';
import '../../theme.dart';

class AddPlant extends StatefulWidget {
  const AddPlant({super.key});

  @override
  State<AddPlant> createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  GardeniaStoreController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColor.background,
          foregroundColor: ThemeColor.blackColor,
          title: const Text(
            'Add Plants',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: controller.key,
                child: Column(
                  children: [
                    InkWell(
                      child: Container(
                        width: size.width * 0.4,
                        height: size.height * 0.2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: controller.addImage.value.isEmpty
                                  ? const AssetImage(
                                      " ",
                                    )
                                  : FileImage(
                                      File(
                                        controller.addImage.value,
                                      ),
                                    ),
                            ),
                            borderRadius: BorderRadius.circular(80)),
                        child: Center(
                            child: controller.addImage.value.isEmpty
                                ? const Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 40,
                                  )
                                : Container()),
                      ),
                      onTap: () {
                        controller.uplaodPhoto();
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFieldWithoutIcon(
                      title: "Plant name",
                      onIconPressed: () {},
                      controller: controller.addPlantName,
                      validate: (val) => validInput(val!, 1, "add", ""),
                      keyboardType: TextInputType.name,
                      obscureText: false,
                    ),
                    const SizedBox(height: 30),
                    CustomTextFieldWithoutIcon(
                      title: "Plant Category",
                      validate: (val) => validInput(val!, 1, "add", ""),
                      onIconPressed: () {},
                      controller: controller.addCategory,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                    ),
                    const SizedBox(height: 30),
                    CustomTextFieldWithoutIcon(
                      title: "Plant Price",
                      onIconPressed: () {},
                      validate: (val) => validInput(val!, 1, "add", ""),
                      controller: controller.addPrice,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                    ),
                    const SizedBox(height: 30),
                    CustomTextFieldWithoutIcon(
                      title: "Plant Description",
                      onIconPressed: () {},
                      validate: (val) => validInput(val!, 1, "add", ""),
                      controller: controller.addDesc,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                    ),
                    const SizedBox(height: 30),
                    PrimaryButton(
                      text: "Add",
                      height: 50,
                      width: 130,
                      onTap: () {
                        controller.addProduct();
                      },
                    ),
                    const SizedBox(height: 30),
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
