import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/function/database_methods.dart';
import 'package:gardenia/models/prduct_model.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:image_picker/image_picker.dart';

class GardeniaStoreController extends GetxController {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final imagePicker = ImagePicker();
  RxBool showdialog = false.obs;
  RxBool isgift = false.obs;

  TextEditingController addPlantName = TextEditingController();
  TextEditingController addPrice = TextEditingController();
  TextEditingController addCategory = TextEditingController();
  TextEditingController addDesc = TextEditingController();

  TextEditingController editPlantName = TextEditingController();
  TextEditingController editPrice = TextEditingController();
  TextEditingController editCategory = TextEditingController();
  TextEditingController editDesc = TextEditingController();
  RxString addImage = ''.obs;
  RxString editImage = ''.obs;
  RxString imageUrl = ''.obs;
  RxString imageEditUrl = ''.obs;
  late String idStore;
  RxBool loadAddProducts = false.obs;
  RxBool loadingEdit = false.obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  Rx<ProductModel> product = ProductModel(
    plantCategory: "",
    plantDesc: "",
    plantName: "",
    plantPrice: "",
    productId: "",
    productImage: "",
    storeId: "",
  ).obs;

  @override
  void onInit() {
    idStore = FirebaseAuth.instance.currentUser!.uid;
    getProducts();
    super.onInit();
  }

  @override
  void onClose() {
    addPlantName.clear();
    addCategory.clear();
    addDesc.clear();
    addPrice.clear();
    addImage.value = "";
    editImage.value = '';
    super.onClose();
  }

  uplaodPhoto() async {
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    addImage.value = pickedImage!.path;
    addImage.refresh();
  }

  uploadeditphoto() async {
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    editImage.value = pickedImage!.path;
    editImage.refresh();
  }

  addProduct() async {
    if (key.currentState!.validate()) {
      print(1);
      String idProduct = randomAlphaNumeric(10);
      imageUrl.value = await DatabaseMethods()
          .uploadProductPicture(idProduct, File(addImage.value));
      print(2);
      print("3");
      Map<String, dynamic> infoProduct = {
        'storeid': idStore,'productId': idProduct,'productImage': imageUrl.value,'plantName': addPlantName.text,
        'plantPrice': addPrice.text,'plantCategory': addCategory.text,'plantDesc': addDesc.text,
      };
      await DatabaseMethods().addCollection(infoProduct, idProduct, "product");
      getProducts();
      addImage.value = '';
      addPlantName.clear();
      addPrice.clear();
      addCategory.clear();
      addDesc.clear();
      Get.back();
      Get.showSnackbar(const GetSnackBar(
        message: "Product Added",
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      ));

      print('go to back ');
    }
  }

  getProducts() async {
    loadAddProducts.value = true;
    loadAddProducts.refresh();
    QuerySnapshot data = await DatabaseMethods()
        .getCollectionWithCondition("product", 'storeid', idStore);
    List data2 = data.docs;
    for (var i in data2) {
      i.data();
    }
    products.value = [];
    products.value.addAll(
        data2.map((doc) => ProductModel.fromMap(doc.data())));
    for (ProductModel p in products.value) {
      print(p.plantName);
    }
    products.refresh();
    loadAddProducts.value = false;
    loadAddProducts.refresh();
  }
  updateProduct(String image, String productId) async {
    loadingEdit.value = true;
    loadingEdit.refresh();
    print("load image");
    if (editImage.isEmpty) {
      Map<String, dynamic> info = {
        'plantName': editPlantName.text,'plantPrice': editPrice.text,
        'plantCategory': editCategory.text,'plantDesc': editDesc.text,
      };
      await DatabaseMethods().updatDoc('product', productId, info);
    } else {
      imageEditUrl.value = await DatabaseMethods()
          .uploadProductPicture(productId, File(editImage.value));
      print("get data");
      Map<String, dynamic> info = {
        'productImage': imageEditUrl.value,
        'plantName': editPlantName.text,
        'plantPrice': editPrice.text,
        'plantCategory': editCategory.text,
        'plantDesc': editDesc.text,
      };
      print('laod product ');
      await DatabaseMethods().updatDoc('product', productId, info);
    }
    editImage.value = '';
    loadingEdit.value = false;
    loadingEdit.refresh();
    Get.back();
    getProducts();
    Get.showSnackbar(const GetSnackBar(
      message: "Modified successfully",
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    ));
  }
  delete(idProduct) async {
    await DatabaseMethods().deleteDoc('product', idProduct);
    await getProducts();
    Get.showSnackbar(const GetSnackBar(message: "Deleted successfully",
      duration: Duration(seconds: 2),snackPosition: SnackPosition.BOTTOM,
    ));
  }

  getAllProducts() async {
    loadAddProducts.value = true;
    loadAddProducts.refresh();
    print("get products ============================");
    QuerySnapshot data = await DatabaseMethods().getCollection(
      "product",
    );

    List data2 = data.docs;
    for (var i in data2) {
      i.data();
    }
    products.value = [];
    products.value.addAll(data2.map((doc) => ProductModel.fromMap(doc.data())));
    print("let me see what products you have ");
    for (ProductModel p in products.value) {
      print(p.plantName);
    }
    products.refresh();
    loadAddProducts.value = false;
    loadAddProducts.refresh();
  }
}
