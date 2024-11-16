import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/function/database_methods.dart';
import 'package:gardenia/models/store_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../view/auth/selectAccountScreen.dart';

class ProfileUserController extends GetxController {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController phone;
  RxBool loadingStore = false.obs;
  String idUser = FirebaseAuth.instance.currentUser!.uid;
  late Rx<UserModle> user = UserModle(
    id: idUser,
    email: "",
    image: '',
    phone: "",
    firstName: "",
    lastName: "",
    password: "",
  ).obs;
  final imagePicker = ImagePicker();
  RxString image = ''.obs;
  RxBool loadingImage = false.obs;

  @override
  void onInit() {
    idUser = FirebaseAuth.instance.currentUser!.uid;
    firstName = TextEditingController();
    lastName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();

    getInfoUser();
    super.onInit();
  }

  uploadinPhoto() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    loadingImage.value = true;
    String urlImage = await DatabaseMethods()
        .uploadProfilePicture(idUser, File(pickedImage!.path));
    image.value = urlImage;
    image.refresh();
    await DatabaseMethods().updatDoc("user", idUser, {"image": urlImage});
    loadingImage.value = false;
    loadingImage.refresh();
  }

  getInfoUser() async {
    loadingStore.value = true;
    loadingStore.refresh();
    DocumentSnapshot data = await DatabaseMethods().getDoc('user', idUser);
    print(data.data());
    user.value = UserModle.fromMap(data.data() as Map<String, dynamic>);
    user.refresh();
    print(user.value.phone);
    image.value = user.value.image;
    firstName.text = user.value.firstName;
    lastName.text = user.value.lastName;
    phone.text = user.value.phone;
    loadingStore.value = false;
    loadingStore.refresh();
    loadingStore.refresh();
  }

  updataInfoStore() async {
    await DatabaseMethods().updatDoc('user', idUser, {
      'firstName': firstName.text,
      'lastName': lastName.text,
      'phone': phone.text
    });
    getInfoUser();
    Get.back();
  }

  deleteStore() async {
    await DatabaseMethods().deleteDoc('user', idUser);
    await DatabaseMethods().deletAccount();
  }

  logout() async {
    await DatabaseMethods().logout();
    Get.offAll(const SelecetAccount());
  }
}
