import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassController extends GetxController {
  late TextEditingController email;

  late TextEditingController newP;

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      Get.defaultDialog(
          content: Text("password reset link sent! check your email"));
    } on FirebaseAuthException catch (e) {
      print(e);
      Get.defaultDialog(
        content: Text(e.message.toString()),
      );
    }
    update();
  }

  reset() async {
    await FirebaseFirestore.instance.collection("user").where("email", isEqualTo: email.text).get().then((value) {
      for (var v in value.docs) {
        if (v.exists) {
          FirebaseFirestore.instance.collection("user").doc(v.id).update({"password": newP.text});
        } else {
          FirebaseFirestore.instance.collection("store").where("email", isEqualTo: email.text).get().then((value) {
            for (var v in value.docs) {
              if (v.exists) {
                FirebaseFirestore.instance.collection("store").doc(v.id).update({"password": newP.text});
              } else {
                FirebaseFirestore.instance.collection("Admin").where("email", isEqualTo: email.text).get()
                    .then((value) {
                  for (var v in value.docs) {
                    if (v.exists) {
                      FirebaseFirestore.instance
                          .collection("Admin")
                          .doc(v.id)
                          .update({"password": newP.text});
                    }
                  }
                });
              }
            }
          });
        }
      }
    });
    passwordReset();
    update();
  }

  @override
  void onInit() {
    email = TextEditingController();
    newP = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    newP.dispose();
    super.onClose();
  }
}
