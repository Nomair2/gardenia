import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/commonWidget/customTextField.dart';
import 'package:gardenia/commonWidget/settings_value.dart';
import 'package:gardenia/controller/user_controller/profile_user_controller.dart';
import 'package:gardenia/theme.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({super.key});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  ProfileUserController controller = Get.put(ProfileUserController());

  final imagePicker = ImagePicker();
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(children: [
          const SizedBox(height: 35),
          FadeInDown(
            delay: const Duration(milliseconds: 200),
            curve: Curves.decelerate,
            child: Obx(
              () => Column(
                children: [
                  controller.loadingImage.value
                      ? const Center(child: CircularProgressIndicator())
                      : Stack(
                          children: [
                            CircleAvatar(
                                radius: 70,
                                backgroundImage: controller.image.isEmpty
                                    ? const AssetImage(
                                        "assets/img/profilePic.png")
                                    : NetworkImage(controller.image.value)),
                            Positioned(
                              right: 10,
                              bottom: 1,
                              child: InkWell(
                                onTap: () async {
                                  controller.uploadinPhoto();
                                },
                                child: CircleAvatar(
                                  backgroundColor: ThemeColor.white,
                                  radius: 20,
                                  child: const Icon(
                                    Icons.camera_alt,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: controller.loadingStore.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20, bottom: 20),
                                  child: Column(children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          right: 15,
                                          bottom: 15,
                                          left: 2.5),
                                      decoration: BoxDecoration(
                                        color: Colors.pinkAccent.shade100
                                            .withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Column(
                                        children: [
                                          SettingsValue(
                                            name: " Name ",
                                            icon: Icons.person,
                                            child: Text(
                                              controller.user.value.firstName,
                                              style: TextStyle(
                                                  color: ThemeColor.white),
                                            ),
                                            onTap2: () {},
                                          ),
                                          SettingsValue(
                                            name: "LastName",
                                            icon: Icons.person,
                                            child: Text(
                                              controller.user.value.lastName,
                                              style: TextStyle(
                                                  color: ThemeColor.white),
                                            ),
                                            onTap2: () {},
                                          ),
                                          const SizedBox(height: 5),
                                          SettingsValue(
                                            name: "Email",
                                            icon: Icons.mail,
                                            child: Text(
                                              controller.user.value.email,
                                              style: TextStyle(
                                                  color: ThemeColor.white),
                                            ),
                                            onTap2: () {},
                                          ),
                                          const SizedBox(height: 5),
                                          SettingsValue(
                                            name: "Password",
                                            icon: Icons.password,
                                            child: Text(
                                              controller.user.value.password,
                                              style: TextStyle(
                                                  color: ThemeColor.white),
                                            ),
                                            onTap2: () {},
                                          ),
                                          const SizedBox(height: 10),
                                          SettingsValue(
                                            name: "Phone",
                                            icon: Icons.person,
                                            child: Text(
                                              controller.user.value.phone,
                                              style: TextStyle(
                                                  color: ThemeColor.white),
                                            ),
                                            onTap2: () {},
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _showEditProfileDialog(context);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 8,
                                                  right: 15,
                                                  left: 15),
                                              decoration: BoxDecoration(
                                                  color: ThemeColor.primary
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                      color: ThemeColor.primary
                                                          .withOpacity(0.15))),
                                              child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                    color: ThemeColor.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20, bottom: 20),
                                  child: Column(children: [
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.pinkAccent.shade100
                                            .withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Column(
                                        children: [
                                          SettingsValue(
                                            name: "Log out ",
                                            icon: Icons.logout_outlined,
                                            child: const SizedBox(),
                                            onTap2: () {
                                              showPlatformDialog(
                                                context: context,
                                                builder: (context) =>
                                                    BasicDialogAlert(
                                                  title: const Text(
                                                      "Are you sure you want to log out ? "),
                                                  actions: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        BasicDialogAction(
                                                          title:
                                                              const Text("Yes"),
                                                          onPressed: () {
                                                            controller.logout();
                                                          },
                                                        ),
                                                        BasicDialogAction(
                                                          title:
                                                              const Text("No"),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 5),
                                          SettingsValue(
                                            name: "Delete Account",
                                            icon: Icons.delete,
                                            child: const SizedBox(),
                                            onTap2: () {
                                              showPlatformDialog(
                                                context: context,
                                                builder: (context) =>
                                                    BasicDialogAlert(
                                                  title: const Text(
                                                      "Are you sure you want to delete the acount ? "),
                                                  actions: <Widget>[
                                                    BasicDialogAction(
                                                      title: const Text("Yes"),
                                                      onPressed: () {
                                                        controller
                                                            .deleteStore();
                                                      },
                                                    ),
                                                    BasicDialogAction(
                                                      title: const Text("No "),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ]),
                                ),
                              ]),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    ));
  }

  void _showEditProfileDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFieldWithoutIcon(
                  onIconPressed: () {},
                  title: "First Name ",
                  controller: controller.firstName,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                CustomTextFieldWithoutIcon(
                  onIconPressed: () {},
                  title: "last Name ",
                  controller: controller.lastName,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                CustomTextFieldWithoutIcon(
                  onIconPressed: () {},
                  title: "Phone",
                  controller: controller.phone,
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Save'),
                  onPressed: () {
                    controller.updataInfoStore();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
