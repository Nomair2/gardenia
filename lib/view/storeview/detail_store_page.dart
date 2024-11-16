import 'package:flutter/material.dart';
import 'package:gardenia/controller/store_controller.dart/gardenia_store_controller.dart';
import 'package:gardenia/models/prduct_model.dart';
import 'package:gardenia/theme.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class DetailStorePage extends StatefulWidget {
  final ProductModel plant;

  const DetailStorePage({super.key, required this.plant});

  @override
  State<DetailStorePage> createState() => _DetailStorePageState();
}

class _DetailStorePageState extends State<DetailStorePage> {
  GardeniaStoreController controller = Get.put<GardeniaStoreController>(
    GardeniaStoreController(),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: ThemeColor.primary.withOpacity(.15),
                      ),
                      child: Icon(
                        Icons.close,
                        color: ThemeColor.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Container(
                width: size.width * .8,
                height: size.height * .8,
                padding: const EdgeInsets.all(20),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 0,
                      child: SizedBox(
                        height: 350,
                        child: Image.network(widget.plant.productImage),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
                height: size.height * .5,
                width: size.width,
                decoration: BoxDecoration(
                  color: ThemeColor.primary.withOpacity(.4),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.plant.plantName,
                              style: TextStyle(
                                color: ThemeColor.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              r'$' + widget.plant.plantPrice.toString(),
                              style: TextStyle(
                                color: ThemeColor.blackColor,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Expanded(
                      child: Text(
                        widget.plant.plantDesc,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 18,
                          color: ThemeColor.blackColor.withOpacity(.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            controller.showdialog.value == true
                ? Positioned(
                    top: size.height * 0.35,
                    left: size.width * 0.1,
                    right: size.width * 0.1,
                    child: FadeInUp(
                      child: Container(
                        width: size.width,
                        height: size.height * 0.2,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ThemeColor.primary,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.showdialog.value = false;
                                    controller.isgift.value = false;
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: ThemeColor.white.withOpacity(.15),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: ThemeColor.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            !controller.isgift.value
                                ? SizedBox(
                                    height: size.height * 0.05,
                                  )
                                : const SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                controller.isgift.value == false
                                    ? Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              controller.isgift.value = true;
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: ThemeColor.white),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 40),
                                                child: const Text("gift")),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              controller.showdialog.value =
                                                  false;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(" Done ")));
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 40),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: ThemeColor.white),
                                              child: const Text("personal"),
                                            ),
                                          )
                                        ],
                                      )
                                    : FadeInLeft(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 60,
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              width: size.width * 0.4,
                                              decoration: BoxDecoration(
                                                color: ThemeColor.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: TextField(
                                                style: TextStyle(
                                                    color: ThemeColor.black,
                                                    decoration:
                                                        TextDecoration.none),
                                                keyboardType:
                                                    TextInputType.phone,
                                                textAlign: TextAlign.start,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      " gift recipient's phone",
                                                  hintStyle: TextStyle(
                                                      color: ThemeColor.black),
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    controller.isgift.value =
                                                        false;
                                                    controller.showdialog
                                                        .value = false;
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 40),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color:
                                                            ThemeColor.white),
                                                    child: const Text(
                                                        "Send Gift "),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ))
                : Container(),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: size.width * .9,
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  print("write ");
                  controller.showdialog.value = true;
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: ThemeColor.primary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          blurRadius: 5,
                          color: ThemeColor.primary.withOpacity(.3),
                        )
                      ]),
                  child: const Center(
                    child: Text(
                      'BUY NOW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDialog(context) async {
    controller.showdialog.value = false;
    await showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        content: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: controller.showdialog.value == true
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ThemeColor.primary),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: const Text("gift")),
                    ),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ThemeColor.primary),
                        child: const Text("personal"),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

class PlantFeature extends StatelessWidget {
  final String plantFeature;
  final String title;

  const PlantFeature({
    super.key,
    required this.plantFeature,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: ThemeColor.blackColor,
          ),
        ),
        Text(
          plantFeature,
          style: TextStyle(
            color: ThemeColor.primary,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
