import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gardenia/function/database_methods.dart';
import 'package:gardenia/models/ordermodel.dart';
import 'package:get/get.dart';

class InyouhandStoreController extends GetxController {
  RxBool loadingOrders = false.obs;
  RxList<Ordermodel> orders = <Ordermodel>[].obs;

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  getOrders() async {
    loadingOrders.value = true;
    loadingOrders.refresh();
    String idStore = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot data = await DatabaseMethods()
        .getOrdersNotAccepted("order", "idstore", idStore);
    List data2 = data.docs;
     orders.value = [];
    orders.addAll(data2.map(
      (e) => Ordermodel.fromJson(e.data()),
    ));
    loadingOrders.value = false;loadingOrders.refresh();
  }
  updateOrder(String idorder) async {
    Map<String, dynamic> info = {"status": "accepted"};
    await DatabaseMethods().updatDoc("order", idorder, info);
    getOrders();
    Get.showSnackbar(const GetSnackBar(message: "Accepted successfully",
      duration: Duration(seconds: 2),snackPosition: SnackPosition.BOTTOM,
    ));
  }
  deleteOrder(String idorder) async {
    await DatabaseMethods().deleteDoc("order", idorder);
    Get.back();
    getOrders();
    Get.showSnackbar(const GetSnackBar(message: "Deleted successfully",
      duration: Duration(seconds: 2),snackPosition: SnackPosition.BOTTOM,
    ));
  }
}
