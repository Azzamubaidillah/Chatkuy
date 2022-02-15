import 'dart:io';
import 'package:chatkuy/app/controllers/auth_controller.dart';
import 'package:chatkuy/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    controller.emailC.text = authC.user.value.email!;
    controller.nameC.text = authC.user.value.name!;
    controller.statusC.text = authC.user.value.status!;
    return Scaffold(
      // onPressed: () => Get.back(),
      // onPressed: () {
      //   authC.changeProfile(
      //     controller.nameC.text,
      //     controller.statusC.text,
      //   );
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(LineAwesomeIcons.angle_left,
                        size: kDefaultPadding * 1.3),
                  ),
                  IconButton(
                    onPressed: () {
                      authC.changeProfile(
                        controller.nameC.text,
                        controller.statusC.text,
                      );
                    },
                    icon: Icon(LineAwesomeIcons.check_circle,
                        size: kDefaultPadding * 1.3),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(125, 15, 125, 15),
                width: 120,
                height: 120,
                child: Obx(
                  () => ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: authC.user.value.photoUrl! == "noimage"
                        ? Image.asset(
                            "assets/logo/noimage.png",
                          )
                        : Image.network(
                            authC.user.value.photoUrl!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.emailC,
                readOnly: true,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: kPrimaryColor)),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.nameC,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: kPrimaryColor)),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.statusC,
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  authC.changeProfile(
                    controller.nameC.text,
                    controller.statusC.text,
                  );
                },
                decoration: InputDecoration(
                  labelText: "Status",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: kPrimaryColor)),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<ChangeProfileController>(
                      builder: (c) => c.pickedImage != null
                          ? Column(
                              children: [
                                Container(
                                  height: 110,
                                  width: 125,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                            image: FileImage(
                                              File(c.pickedImage!.path),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: -10,
                                        right: -5,
                                        child: IconButton(
                                          onPressed: () => c.resetImage(),
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red[800],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => c
                                      .uploadImage(authC.user.value.uid!)
                                      .then((hasilKembalian) {
                                    if (hasilKembalian != null) {
                                      authC.updatePhotoUrl(hasilKembalian);
                                    }
                                  }),
                                  child: Text(
                                    "upload",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Text("Change Photo Profile"),
                    ),
                    TextButton(
                      onPressed: () => controller.selectImage(),
                      child: Text(
                        "choose",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () {
                    authC.changeProfile(
                      controller.nameC.text,
                      controller.statusC.text,
                    );
                  },
                  child: Text(
                    "UPDATE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
