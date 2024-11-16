import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:gardenia/controller/store_controller.dart/inyouhand_store_controller.dart';
import 'package:gardenia/models/ordermodel.dart';
import 'package:gardenia/theme.dart';
import 'package:get/get.dart';

class StoreOrder extends StatefulWidget {
  final Ordermodel order;

  const StoreOrder({
    super.key,
    required this.order,
  });

  @override
  _StoreOrderState createState() => _StoreOrderState();
}

class _StoreOrderState extends State<StoreOrder> {
  InyouhandStoreController controller = Get.find<InyouhandStoreController>();

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
                    Text(widget.order.nameUser),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.order.phone),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.order.type),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.order.price),
                  ],
                ),
                const Icon(
                  Icons.task_alt,
                  size: 50,
                  color: Colors.pinkAccent,
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
                    _orderDialog(context);
                  },
                  child: Text(
                    'Reject',
                    style: TextStyle(color: ThemeColor.black),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Colors.green.withOpacity(0.6))),
                  onPressed: () {
                    controller.updateOrder(widget.order.idOrder);
                  },
                  child: Text(
                    'Accept',
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

  Future<dynamic> _orderDialog(BuildContext context) {
    return showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: const Center(child: Text("Be careful")),
        content: const Text("Are you sure you want to reject this order ?"),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BasicDialogAction(
                title: const Text(
                  "Yes",
                ),
                onPressed: () {
                  controller.deleteOrder(widget.order.idOrder);
                },
              ),
              BasicDialogAction(
                title: const Text(
                  "No",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
