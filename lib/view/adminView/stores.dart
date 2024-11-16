import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../commonWidget/customeCardAdmin.dart';
import '../../controller/admin_controller/adminController.dart';

class Stores extends StatelessWidget {
  const Stores({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("store")
                    .where("status", isEqualTo: "enable")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: snap.length,
                        itemBuilder: (context, index) {
                          return GetBuilder<AdminController>(
                              builder: (controller) => CustomeCardAdmin(
                                    onPressed: () {
                                      controller.delete(
                                          snap[index].id, "store");
                                    },
                                    name: snap[index]["name"],
                                    email: snap[index]["email"],
                                    phone: snap[index]["phone"],
                                  ));
                        });
                  } else {
                    return const CircularProgressIndicator();
                  }
                })
          ],
        ),
      ),
    );
  }
}
