import 'package:animate_do/animate_do.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/function/database_methods.dart';
import 'package:gardenia/view/auth/selectAccountScreen.dart';
import 'package:get/get.dart';
import '../../controller/admin_controller/adminController.dart';
import '../../theme.dart';

class BottomNavBarAdmin extends GetView<AdminController> {
  const BottomNavBarAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminController());
    return SafeArea(
        child: GetBuilder<AdminController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ThemeColor.background,
          title: ZoomIn(
            delay: const Duration(milliseconds: 150),
            child: Text("Admin",
                style: TextStyle(color: ThemeColor.white, fontSize: 23)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 40, right: 15),
              child: Row(
                children: [
                  const Text(
                    "log out ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  ZoomIn(
                      child: IconButton(
                          onPressed: () async {
                            await DatabaseMethods().logout();
                            Get.offAll(const SelecetAccount());
                          },
                          icon: Icon(
                            Icons.logout,
                            color: ThemeColor.white,
                          ))),
                ],
              ),
            )
          ],
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.blueAccent,
          index: controller.index!,
          height: 60,
          animationDuration: const Duration(milliseconds: 300),
          maxWidth: MediaQuery.of(context).size.width * 0.99,
          items: const [
            Padding(
              padding: EdgeInsets.all(3),
              child: Column(
                children: [Icon(Icons.person, size: 25), Text("Users")],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3),
              child: Column(
                children: [
                  Icon(Icons.person_outline, size: 25),
                  Text("Stores")
                ],
              ),
            ),
          ],
          onTap: (index) {
            controller.onTap(index);
          },
        ),
        body: controller.screens[controller.index!],
      ),
    ));
  }
}
