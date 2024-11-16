import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/view/adminView/manageUsersAccounts.dart';
import 'package:get/get.dart';
import '../../function/database_methods.dart';
import '../../view/adminView/manageStoreAccounts.dart';

class AdminController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String? account;
  List<Widget> screens = [
    const ManageUsersAccounts(),
    ManageStoreAccounts(),
  ];
  int? index = 0;

  onChanged(String? value) {
    account = value!;
    update();
  }

  onTap(i) {
    index = i;
    update();
  }

  addUser() async {
    if (key.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        String iduser = FirebaseAuth.instance.currentUser!.uid;
        Map<String, dynamic> infouser = {
          "name": name.text,
          "address": address.text,
          "email": email.text,
          "password": password.text,
          'image': '',
          "id": iduser,
        };
        await DatabaseMethods().addCollection(
            infouser, iduser, account == "Owner" ? "owner" : "investor");
        Get.back();
        Get.showSnackbar(
          const GetSnackBar(
            message: "user account created ",
            duration: Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
          ),
        );
      } on FirebaseAuthException catch (e) {
        print("2");
        print(e.code);
        if (e.code == 'weak-password') {
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
    update();
  }

  delete(String id, String collection) async {
    await FirebaseFirestore.instance.collection(collection).doc(id).delete();
    Get.snackbar("Success", " deleted successfully!!");
    update();
  }

  accept(String index) async {
    try {
      await FirebaseFirestore.instance
          .collection("store")
          .doc(index)
          .update({"status": "enable"});
      Get.back();
      Get.snackbar("Success", "Accepted");
    } catch (e) {
      Get.snackbar("Error", "Failed to accept store account: $e");
    }

    update();
  }

  reject(String index) async {
    try {
      await FirebaseFirestore.instance
          .collection("store")
          .doc(index)
          .update({"status": "disable"});
      Get.back();
      Get.snackbar("Success", "Rejected");
    } catch (e) {
      Get.snackbar("Error", "Failed to reject store account: $e");
    }

    update();
  }
}
