import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/commonWidget/customTextField.dart';
import 'package:gardenia/commonWidget/upperLogo.dart';
import 'package:gardenia/controller/auth_controller/singup_store_controller.dart';
import 'package:gardenia/function/validinput.dart';
import 'package:gardenia/theme.dart';
import 'package:get/get.dart';

class StoreRegisterScreen extends StatefulWidget {
  const StoreRegisterScreen({super.key});

  @override
  State<StoreRegisterScreen> createState() => _StoreRegisterScreenState();
}

class _StoreRegisterScreenState extends State<StoreRegisterScreen> {
  SingupStoreController controller = Get.put(SingupStoreController());

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
                    validate: (val) => validInput(val!, 1, "lastName", ""),
                    title: "Name ",
                    controller: controller.name,
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
                    onIconPressed: () {},
                    title: "Password",
                    validate: (val) => validInput(val!, 8, "password", ""),
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
                    controller: controller.phone,
                    validate: (val) => validInput(val!, 10, "phone", ""),
                    keyboardType: const TextInputType.numberWithOptions(),
                    obscureText: false,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: CustomTextField(
                    icon: const Icon(Icons.location_city_outlined),
                    onIconPressed: () {},
                    title: "Location",
                    validate: (val) => validInput(val!, 1, "location", ""),
                    controller: controller.location,
                    keyboardType: TextInputType.streetAddress,
                    obscureText: false,
                  ),
                ),
                SizedBox(height: height * 0.1),
                FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: InkWell(
                      onTap: () {
                        controller.signup();
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
                            ' Sign up ',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
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
