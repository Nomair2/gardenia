import 'package:flutter/material.dart';
import 'package:gardenia/controller/store_controller.dart/inyouhand_store_controller.dart';
import 'package:gardenia/theme.dart';
import 'package:get/get.dart';
import 'store_request.dart';

class RequestView extends StatefulWidget {
  const RequestView({super.key});

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  InyouhandStoreController controller = Get.put(InyouhandStoreController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ThemeColor.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Requests',
              style: TextStyle(
                color: ThemeColor.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            const Icon(Icons.remove)
          ],
        ),
        backgroundColor: ThemeColor.background,
        elevation: 0.0,
      ),
      body: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: size.height,
          child: controller.loadingOrders.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: controller.orders.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return StoreOrder(
                      order: controller.orders.value[index],
                    );
                  }),
        ),
      ),
    );
  }
}
