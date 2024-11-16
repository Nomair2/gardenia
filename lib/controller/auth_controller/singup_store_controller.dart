import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/sevices/database_methods.dart';
import 'package:get/get.dart';
import '../../view/auth/login_Screen.dart';

class SingupStoreController extends GetxController {
  late TextEditingController name;
  late TextEditingController location;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController phone;
  late GlobalKey<FormState> key;

  @override
  void onInit() {
    name = TextEditingController();
    location = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();
    key = GlobalKey<FormState>();
    super.onInit();
  }

  signup() async {
    if (key.currentState!.validate()) {
      try {
        print("now we will go to firebase auth ");
        print(
            "we finish from firebase auth and we will get id user and collect data user  ");
        UserCredential usercurrent =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        String idStore = FirebaseAuth.instance.currentUser!.uid;

        Map<String, dynamic> infoUser = {
          "name": name.text,
          "location": location.text,
          "email": email.text,
          "password": password.text,
          "phone": phone.text,
          'image': '',
          "id": idStore,
          "status": "pending"
        };
        print("now we will store data no storage firebase ");
        await DatabaseMethods().addStore(infoUser, idStore);
        Get.showSnackbar(const GetSnackBar(
          message: "Store account created ",
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        ));
        Get.off(LoginScreen());
      } on FirebaseAuthException catch (e) {
        print("2");
        print(e.code);
        if (e.code == 'weak-password') {
          print("3");
          Get.showSnackbar(const GetSnackBar(
            message: " Weak Password",
            duration: Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
          ));
        } else if (e.code == 'email-already-in-use') {
          Get.showSnackbar(const GetSnackBar(
            message: "Account already exists ",
            duration: Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
          ));
        }
      }
    }
  }
}
