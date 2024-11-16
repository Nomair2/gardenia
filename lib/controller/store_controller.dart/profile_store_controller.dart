import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/function/database_methods.dart';
import 'package:gardenia/models/store_model.dart';
import 'package:gardenia/view/auth/selectAccountScreen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileStoreController extends GetxController {
  late TextEditingController name;
  late TextEditingController location;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController phone;
  RxBool loadingStore = false.obs;
  String idStore = FirebaseAuth.instance.currentUser!.uid;
  late Rx<StoreModel> store = StoreModel(
    id: idStore,
    email: "",
    image: '',
    phone: "",
    location: "",
    name: "",
    password: "",
  ).obs;
  final imagePicker = ImagePicker();
  RxString image = ''.obs;
  RxBool loadingImage = false.obs;

  @override
  void onInit() {
    idStore = FirebaseAuth.instance.currentUser!.uid;
    name = TextEditingController();
    location = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();

    getInfoStore();
    super.onInit();
  }

  uploadinPhoto() async {
    loadingImage.value = true;
    print(1);
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    print(2);
    String urlImage = await DatabaseMethods()
        .uploadProfilePicture(idStore, File(pickedImage!.path));
    print(3);
    image.value = urlImage;
    image.refresh();
    await DatabaseMethods().updatDoc("store", idStore, {"image": urlImage});
    print(4);
    loadingImage.value = false;
    loadingImage.refresh();
  }

  getInfoStore() async {
    loadingStore.value = true;
    loadingStore.refresh();
    DocumentSnapshot data = await DatabaseMethods().getDoc('store', idStore);
    store.value = StoreModel.fromMap(data.data() as Map<String, dynamic>);
    store.refresh();
    image.value = store.value.image;
    name.text = store.value.name;
    location.text = store.value.location;
    phone.text = store.value.phone;
    loadingStore.value = false;loadingStore.refresh();loadingStore.refresh();
  }
  updataInfoStore() async {
    await DatabaseMethods().updatDoc('store', idStore,
        {'name': name.text, 'location': location.text, 'phone': phone.text});
    getInfoStore();
    Get.back();
  }
  deleteStore() async {
    await DatabaseMethods().deleteDoc('store', idStore);
    await DatabaseMethods().deletAccount();
  }

  logout() async {
    await DatabaseMethods().logout();
    Get.offAll(const SelecetAccount());
  }
}
