import 'package:flutter/material.dart';
import 'package:gardenia/view/auth/selectAccountScreen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAovz0ooYL2-RZzbQyfYKEzOJoQNGT3vkQ',
    projectId: 'gardenia-5d43e',
    messagingSenderId: '837239169611',
    appId: '1:837239169611:android:dba7efd7e123b3e97b23ce',
    storageBucket: 'gardenia-5d43e.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelecetAccount(),
    );
  }
}
