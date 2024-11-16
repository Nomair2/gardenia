import 'package:flutter/material.dart';
import 'package:gardenia/sevices/database_methods.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../view/auth/login_Screen.dart';

class SignupUserController extends GetxController {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController phone;
  late GlobalKey<FormState> key;
  RxBool isloading = false.obs;

  @override
  void onInit() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();
    key = GlobalKey<FormState>();
    super.onInit();
  }

  signup() async {
    if (key.currentState!.validate()) {
      try {
        UserCredential usercurrent =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        isloading.value = true;
        isloading.refresh();
        String idUser = FirebaseAuth.instance.currentUser!.uid;
        Map<String, dynamic> infoUser = {
          "firstName": firstName.text,
          "lastName": lastName.text,
          "phone": phone.text,
          "email": email.text,
          "password": password.text,
          "id": idUser,
        };
        await DatabaseMethods().addUser(infoUser, idUser);
        isloading.value = false;
        isloading.refresh();
        Get.showSnackbar(const GetSnackBar(
          message: "User account created ",
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        ));
        Get.off(LoginScreen());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          isloading.value = false;
          isloading.refresh();
          Get.showSnackbar(const GetSnackBar(
            message: " Weak Password",
            duration: Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
          ));
        } else if (e.code == 'email-already-in-use') {
          isloading.value = false;
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
