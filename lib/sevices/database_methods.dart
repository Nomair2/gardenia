import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future addUser(Map<String, dynamic> infoUser, String id) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .doc(id)
        .set(infoUser);
  }

  Future addStore(Map<String, dynamic> infoSreviceProvider, String id) async {
    return await FirebaseFirestore.instance
        .collection("store")
        .doc(id)
        .set(infoSreviceProvider);
  }
}
