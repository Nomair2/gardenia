import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/commonWidget/primareButton.dart';
import 'package:gardenia/commonWidget/upperLogo.dart';
import 'package:gardenia/theme.dart';
import 'package:gardenia/view/auth/User_register_screen.dart';
import 'package:gardenia/view/auth/store_register_screen.dart';
import 'package:get/get.dart';
import 'login_Screen.dart';

class SelecetAccount extends StatelessWidget {
  const SelecetAccount({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: UpperLogo(width: width * 0.5, height: height)),
              SizedBox(height: height * 0.08),
              FadeInDown(
                delay: const Duration(milliseconds: 320),
                child: Text(
                  "Select Account type ",
                  style: TextStyle(
                      color: ThemeColor.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              FadeInDown(
                  delay: const Duration(milliseconds: 340),
                  child: PrimaryButton(
                      width: 150,
                      height: 50,
                      onTap: () {
                        Get.to(const UserRegisterScreen());
                      },
                      text: "User")),
              const SizedBox(height: 15),
              FadeInDown(
                  delay: const Duration(milliseconds: 360),
                  child: PrimaryButton(
                      height: 50,
                      width: 150,
                      onTap: () {
                        Get.to(const StoreRegisterScreen());
                      },
                      text: "Store")),
              const SizedBox(height: 15),
              FadeInDown(
                delay: const Duration(milliseconds: 370),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Aleardy have account ? ",
                      style: TextStyle(
                          color: ThemeColor.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: ThemeColor.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                      onPressed: () {
                        Get.to(const LoginScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
