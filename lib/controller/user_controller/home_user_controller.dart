import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gardenia/function/database_methods.dart';
import 'package:gardenia/models/prduct_model.dart';
import 'package:get/get.dart';

class HomeUserController extends GetxController {
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxBool loadingProducts = false.obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  getProducts() async {
    loadingProducts.value = true;
    loadingProducts.refresh();
    QuerySnapshot data = await DatabaseMethods()
        .getCollection('product');
    List data2 = data.docs;
    print(data2);
    products.value = [];
    products.addAll(data2.map(
      (e) => ProductModel.fromMap(e.data()),
    ));
    products.refresh();
    loadingProducts.value = false;
    loadingProducts.refresh();
  }
}
