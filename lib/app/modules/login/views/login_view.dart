import 'package:chatkuy/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:chatkuy/app/controllers/auth_controller.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset("assets/image/welcome.png"),
                ),
                SizedBox(height: 150),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                      onPressed: () => authC.login(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign in with ",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Google",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xFFF4B400)),
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
