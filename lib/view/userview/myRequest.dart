import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/theme.dart';
import 'package:gardenia/view/userview/payment.dart';
import 'package:get/get.dart';

class MyRequest extends StatelessWidget {
  const MyRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("order")
                .where("idUser",
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final snap = snapshot.data!.docs;
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: ListView.builder(
                    itemCount: snap.length,
                    itemBuilder: (context, index) {
                      return FadeInLeft(
                          delay: const Duration(milliseconds: 300),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ThemeColor.white),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Request Type",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(snap[index]["type"]),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Price",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(snap[index]["price"]),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            snap[index]["date"]
                                                .toDate()
                                                .toString()
                                                .substring(0, 10),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            snap[index]["date"]
                                                .toDate()
                                                .toString()
                                                .substring(10, 16),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      snap[index]["status"] == "waiting"
                                          ? ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStateProperty.all(
                                                          Colors.red
                                                              .withOpacity(
                                                                  0.6))),
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection("order")
                                                    .doc(snap[index].id)
                                                    .delete();
                                                Get.snackbar("success",
                                                    "Your order has been deleted successfully");
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: ThemeColor.black),
                                              ),
                                            )
                                          : snap[index]["status"] == "accepted"
                                              ? ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all(Colors.red
                                                                  .withOpacity(
                                                                      0.6))),
                                                  onPressed: () async {
                                                    Get.to(Payment(
                                                      orderID: snap[index].id,
                                                      price: snap[index]
                                                          ["price"],
                                                    ));
                                                  },
                                                  child: Text(
                                                    'Pay',
                                                    style: TextStyle(
                                                        color:
                                                            ThemeColor.black),
                                                  ),
                                                )
                                              : Text(
                                                  snap[index]["status"],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}
