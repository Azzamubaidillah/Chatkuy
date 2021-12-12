import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: Get.width * 0.8,
              height: Get.width * 0.8,
              child: Lottie.asset("assets/lottie/login.json"),
            ),
            SizedBox(height: 150),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          child: Image.asset("assets/logo/google.png")),
                      SizedBox(width: 15),
                      Text(
                        "Sign in with Google",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red[900],
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
            )
          ]),
        ),
      ),
    ));
  }
}