import 'package:flutter/material.dart';
import 'package:gardenia/commonWidget/CustomOrder.dart';
import 'package:gardenia/controller/user_controller/inyourhand_User_controller.dart';
import 'package:get/get.dart';

class Inyourhandscreen extends StatefulWidget {
  const Inyourhandscreen({super.key});

  @override
  State<Inyourhandscreen> createState() => _InyourhandscreenState();
}

class _InyourhandscreenState extends State<Inyourhandscreen> {
  InYourhandUserController controller = Get.put(InYourhandUserController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: size.height,
          child: controller.loadingstores.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: controller.stores.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return CustomerOrder(
                      store: controller.stores.value[index],
                    );
                  }),
        ),
      ),
    );
  }
}
