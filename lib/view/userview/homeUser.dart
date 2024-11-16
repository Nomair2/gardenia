import 'package:flutter/material.dart';
import 'package:gardenia/controller/user_controller/home_user_controller.dart';
import 'package:gardenia/view/userview/detail_User_page.dart';
import 'package:gardenia/view/common_widget/plant_widget.dart';
import 'package:get/get.dart';

class Homeuser extends StatefulWidget {
  const Homeuser({super.key});

  @override
  State<Homeuser> createState() => _HomeuserState();
}

class _HomeuserState extends State<Homeuser> {
  HomeUserController controller = Get.put(HomeUserController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: size.height,
          child: controller.loadingProducts.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: controller.products.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return PlantWidget(
                      index: index,
                      plant: controller.products.value[index],
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailUserPage(
                                      plant: controller.products.value[index],
                                    )));
                      },
                    );
                  }),
        ),
      ),
    );
  }
}
