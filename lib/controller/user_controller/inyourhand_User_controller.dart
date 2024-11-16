import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gardenia/function/database_methods.dart';
import 'package:gardenia/models/store_model.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

class InYourhandUserController extends GetxController {
  RxList<StoreModel> stores = <StoreModel>[].obs;
  RxBool loadingstores = false.obs;
  RxBool loadingrequest = false.obs;

  @override
  void onInit() {
    getStores();
    super.onInit();
  }

  getStores() async {
    loadingstores.value = true;
    loadingstores.refresh();
    QuerySnapshot data = await DatabaseMethods().getCollection("store");
    List data2 = data.docs;
    stores.addAll(data2.map(
      (e) => StoreModel.fromMap(e.data()),
    ));
    stores.refresh();
    loadingstores.value = false;
    loadingstores.refresh();
  }

  request(idstore, String type, String price, String rPhone) async {
    loadingstores.value = true;
    loadingstores.refresh();
    String idUser = FirebaseAuth.instance.currentUser!.uid;
    String idOrder = randomAlphaNumeric(10);
    DocumentSnapshot userdata = await DatabaseMethods().getDoc("user", idUser);
    print(userdata.data());
    UserModle user = UserModle.fromMap(userdata.data() as Map<String, dynamic>);

    Map<String, dynamic> info = {
      'idOrder': idOrder,'idstore': idstore,"idUser": idUser,
      'nameUser': "${user.firstName} ${user.lastName}",
      'phone': user.phone,'status': "waiting","type": type,
      "price": price,"recipientPhone": rPhone,"date": DateTime.now()
    };
    await DatabaseMethods().addCollection(info, idOrder, "order");
    loadingstores.value = false;
    loadingstores.refresh();
    Get.showSnackbar(const GetSnackBar(
      message: "sent successfully",
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    ));
  }
}
