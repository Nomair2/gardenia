import 'package:flutter/material.dart';
import 'package:gardenia/controller/user_controller/inyourhand_User_controller.dart';
import 'package:gardenia/models/store_model.dart';
import 'package:gardenia/theme.dart';
import 'package:get/get.dart';

class CustomerOrder extends StatelessWidget {
  final StoreModel store;

  CustomerOrder({
    super.key,
    required this.store,
  });

  InYourhandUserController controller = Get.find<InYourhandUserController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ThemeColor.primary.withOpacity(.5)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(store.name),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(store.phone),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(store.location),
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(store.image),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.red.withOpacity(0.6))),
                  onPressed: () {
                    controller.request(
                        store.id, "in your hand service", "", "");
                  },
                  child: Text(
                    'request In Your Hands service',
                    style: TextStyle(color: ThemeColor.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
