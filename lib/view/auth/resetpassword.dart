import 'package:flutter/material.dart';
import 'package:gardenia/theme.dart';
import 'package:get/get.dart';
import '../../commonWidget/customTextField.dart';
import '../../controller/auth_controller/resetPasswordController.dart';

class ResetPassword extends GetView<ResetPassController> {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPassController());
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: ThemeColor.background,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 330, top: 40),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 30,
                      color: Colors.white,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: GetBuilder<ResetPassController>(
                      builder: (controller) => Column(
                        children: [
                           Padding(
                            padding: const EdgeInsets.only(right: 300),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ThemeColor.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: CustomTextField(
                              onIconPressed: () {},
                              title: "Email",
                              icon:  Icon(Icons.email,color:ThemeColor.primary,),
                              validate: (val) {},
                              titleAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              controller: controller.email,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                           Padding(
                            padding: const EdgeInsets.only(right: 230),
                            child: Text(
                              "New Password",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:ThemeColor.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: CustomTextField(
                              onIconPressed: () {},
                              title: "New Password",
                              icon:  Icon(Icons.visibility,color:ThemeColor.primary,),
                              validate: (val) {},
                              titleAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              controller: controller.newP,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          MaterialButton(
                              minWidth: 320,
                              height: 50,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: ThemeColor.primary,
                              child: const Text(
                                "Reset Password",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                controller.reset();
                              }),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),)

            ],
          ),
        ),
      ),
    );
  }
}
