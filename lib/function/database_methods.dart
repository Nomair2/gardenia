import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseMethods {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future addCollection(
      Map<String, dynamic> info, String id, String collection) async {
    return await FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .set(info);
  }

  Future<QuerySnapshot> getCollectionWithCondition(
      String collection, field, value) async {
    return await FirebaseFirestore.instance
        .collection(collection)
        .where(field, isEqualTo: value)
        .get();
  }

  Future<QuerySnapshot> getOrdersNotAccepted(
      String collection, field, value) async {
    return await FirebaseFirestore.instance
        .collection(collection)
        .where('status', isEqualTo: 'waiting')
        .where(field, isEqualTo: value)
        .get();
  }

  Future<QuerySnapshot> getCollection(
    String collection,
  ) async {
    return await FirebaseFirestore.instance.collection(collection).get();
  }

  Future<DocumentSnapshot> getDoc(String collection, String id) async {
    return await FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .get();
  }

  Future updatDoc(
      String collection, String id, Map<String, dynamic> info) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .update(info);
  }

  Future deleteDoc(
    String collection,
    String id,
  ) async {
    await FirebaseFirestore.instance.collection(collection).doc(id).delete();
  }

  Future deletAccount() async {
    FirebaseAuth.instance.currentUser!.delete();
  }

  Future logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future uploadProductPicture(String uid, File profilePicture) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref('productImages/${uid}/profilePicture.jpg');

      UploadTask uploadTask = storageReference.putFile(profilePicture);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      print('Profile picture uploaded successfully');
      print('Download URL: $downloadURL');
      return downloadURL;
    } catch (e) {
      print('Error uploading profile picture: $e');
      rethrow;
    }
  }

  Future uploadProfilePicture(String uid, File profilePicture) async {
    try {
      print(
          " Create a reference to the location where we want to upload the file");
      Reference storageReference = FirebaseStorage.instance
          .ref('profileImages/${uid}/profilePicture.jpg');

      UploadTask uploadTask = storageReference.putFile(profilePicture);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      print('Profile picture uploaded successfully');
      print('Download URL: $downloadURL');
      return downloadURL;
    } catch (e) {
      print('Error uploading profile picture: $e');
      rethrow;
    }
  }
}
