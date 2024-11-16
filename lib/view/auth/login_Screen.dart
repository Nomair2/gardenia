import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/commonWidget/customTextField.dart';
import 'package:gardenia/commonWidget/upperLogo.dart';
import 'package:gardenia/function/validinput.dart';
import 'package:gardenia/theme.dart';
import 'package:gardenia/view/auth/resetpassword.dart';
import 'package:gardenia/view/auth/selectAccountScreen.dart';

import 'package:get/get.dart';

import '../../controller/auth_controller/loginController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: controller.key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(
                    delay: const Duration(milliseconds: 300),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UpperLogo(width: width * 0.5, height: height),
                      ],
                    )),
                SizedBox(height: height * 0.05),
                FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: CustomTextField(
                    icon: const Icon(Icons.mail_outline),
                    onIconPressed: () {},
                    title: "Email",
                    validate: (val) => validInput(val!, 1, "email", ""),
                    controller: controller.email,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: CustomTextField(
                    icon: const Icon(Icons.lock_outline),
                    validate: (val) => validInput(val!, 8, "password", ""),
                    onIconPressed: () {},
                    title: "Password",
                    controller: controller.password,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                  ),
                ),
                SizedBox(height: height * 0.1),
                FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: InkWell(
                    onTap: () {
                      controller.checkEmail();
                    },
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ThemeColor.primary),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: const Center(
                        child: Text(
                          ' login ',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: FadeInDown(
                    delay: const Duration(milliseconds: 300),
                    child: InkWell(
                      onTap: (){
                        Get.to(const ResetPassword());
                      },
                      child: Text(
                        "Forgot password ? ",
                        style: TextStyle(
                            color: ThemeColor.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                FadeInDown(
                  delay: const Duration(milliseconds: 370),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ? ",
                        style: TextStyle(
                            color: ThemeColor.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: ThemeColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        onPressed: () {
                          Get.offAll(const SelecetAccount());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
