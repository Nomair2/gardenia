import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/commonWidget/customTextField.dart';
import 'package:gardenia/commonWidget/upperLogo.dart';
import 'package:gardenia/controller/auth_controller/signup_user_controller.dart';
import 'package:gardenia/function/validinput.dart';
import 'package:gardenia/theme.dart';
import 'package:get/get.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  SignupUserController controller = Get.put(SignupUserController());

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
                FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: const Text(
                    "Sign up",
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
                    icon: const Icon(Icons.person_outline),
                    onIconPressed: () {},
                    title: "First Name",
                    validate: (val) => validInput(val!, 1, "firstName", ""),
                    controller: controller.firstName,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: CustomTextField(
                    icon: const Icon(Icons.person_outline),
                    validate: (val) => validInput(val!, 1, "lastName", ""),
                    onIconPressed: () {},
                    title: "Last Name",
                    controller: controller.lastName,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: CustomTextField(
                    icon: const Icon(Icons.mail_outline),
                    onIconPressed: () {},
                    validate: (val) => validInput(val!, 1, "email", ""),
                    title: "Email",
                    controller: controller.email,
                    keyboardType: TextInputType.emailAddress,
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
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: CustomTextField(
                    icon: const Icon(Icons.phone_outlined),
                    onIconPressed: () {},
                    title: "Phone",
                    validate: (val) => validInput(val!, 10, "phone", ""),
                    controller: controller.phone,
                    keyboardType: const TextInputType.numberWithOptions(),
                    obscureText: false,
                  ),
                ),
                SizedBox(height: height * 0.1),
                FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: InkWell(
                    onTap: () {
                      controller.signup();
                    },
                    // onTap: () => Get.off(LoginScreen(screen: BottomNavBarUser())),
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ThemeColor.primary),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: const Center(
                        child: Text(
                          ' Sign up ',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
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
