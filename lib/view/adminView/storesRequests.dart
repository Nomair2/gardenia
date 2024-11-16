import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:gardenia/controller/admin_controller/adminController.dart';
import 'package:get/get.dart';
import '../../commonWidget/storeInfoTile.dart';
import '../../theme.dart';

class Storesrequests extends StatelessWidget {
  const Storesrequests({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminController());
    return Scaffold(
        body: GetBuilder<AdminController>(
      builder: (controller) => Container(
        color: ThemeColor.background,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("store")
                        .where("status", isEqualTo: "pending")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final snap = snapshot.data!.docs;
                        return ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: snap.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ThemeColor.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      children: [
                                        StoreInfoTile(
                                          title: snap[index]["name"],
                                          value: "Name",
                                        ),
                                        StoreInfoTile(
                                          title: snap[index]["email"],
                                          value: "Email",
                                        ),
                                        StoreInfoTile(
                                          title: snap[index]["phone"],
                                          value: "Phone",
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            MaterialButton(
                                              onPressed: () {
                                                _cancelOrder(
                                                  context,
                                                  () {
                                                    controller
                                                        .reject(snap[index].id);
                                                  },
                                                );
                                              },
                                              color: Colors.red,
                                              child: const Text("Reject"),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                controller
                                                    .accept(snap[index].id);
                                              },
                                              color: Colors.green,
                                              child: const Text("Accept"),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const CircularProgressIndicator();
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    ));
  }

  _cancelOrder(BuildContext context, void Function() onPressed) async {
    await showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: const Center(child: Text("Reject This Store??")),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BasicDialogAction(
                  title: Text(
                    "Yes",
                    style: TextStyle(color: ThemeColor.primary),
                  ),
                  onPressed: onPressed),
              BasicDialogAction(
                title: Text(
                  "No",
                  style: TextStyle(color: ThemeColor.primary),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
