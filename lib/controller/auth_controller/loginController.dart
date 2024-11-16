import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../view/adminView/bottomNavBarAdmin.dart';
import '../../view/storeview/bottom_nav_store.dart';
import '../../view/userview/bottomNavUser.dart';

class LoginController extends GetxController {
  late GlobalKey<FormState> key;
  late TextEditingController email;
  late TextEditingController password;
  GetStorage getStorage = GetStorage();

  @override
  void onInit() {
    key = GlobalKey<FormState>();

    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  Future Login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("no user found for that email");
      } else if (e.code == "wrong-password") {
        print("wrong password provided for that user");
      }
    } catch (e) {
      print(e);
    }
  }

  Future checkEmail() async {
    await Login().then((value) {
      if (value == null) {
        FirebaseFirestore.instance
            .collection("user")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((val) {
          if (val.exists) {
            if (val.data()!["email"] == email.text &&
                val.data()!["password"] == password.text) {
              Get.offAll(const BottomNavBarUser());
            } else {
              Get.snackbar(
                "Faild Login",
                "Wrong password or email, please try again",
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 3),
              );
            }
          } else {
            FirebaseFirestore.instance
                .collection("store")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get()
                .then((val) {
              if (val.exists) {
                if (val.data()!["email"] == email.text &&
                    val.data()!["password"] == password.text) {
                  var userStatus = val.data()!["status"];
                  if (userStatus == "enable") {
                    Get.offAll(const BottomNavStore());
                  } else {
                    Get.snackbar("Alert", "Your account is not activated yet");
                  }
                } else {
                  Get.snackbar(
                    "Faild Login",
                    "Wrong password or email, please try again",
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 3),
                  );
                }
              } else {
                FirebaseFirestore.instance
                    .collection("Admin")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get()
                    .then((val) {
                  if (val.exists) {
                    if (val.data()!["email"] == email.text &&
                        val.data()!["password"] == password.text) {
                      Get.offAll(const BottomNavBarAdmin());
                    } else {
                      Get.snackbar(
                        "Faild Login",
                        "Wrong password or email, please try again",
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 3),
                      );
                    }
                  } else {
                    Get.snackbar(
                      "Faild Login",
                      "User Not Found",
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 1),
                    );
                  }
                });
              }
            });
          }
        });
      }
    });
  }
}
