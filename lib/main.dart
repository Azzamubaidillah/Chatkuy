import 'package:chatkuy/app/controllers/auth_controller.dart';
import 'package:chatkuy/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      return Obx(
        () => GetMaterialApp(
          title: "Chatkuy",
          debugShowCheckedModeBanner: false,
          theme: lightThemeData(context),
          darkTheme: darkThemeData(context),
          initialRoute: authC.isSkipIntro.isTrue
              ? authC.isAuth.isTrue
                  ? Routes.HOME
                  : Routes.LOGIN
              : Routes.INTRODUCTION,
          getPages: AppPages.routes,
        ),
      );

      // return GetMaterialApp(
      //   title: "Chatkuy",
      //   debugShowCheckedModeBanner: false,
      //   theme: lightThemeData(context),
      //   darkTheme: darkThemeData(context),
      //   initialRoute: Routes.LOGIN,
      //   getPages: AppPages.routes,
      // );
    });

    // //one complete, show your applicationId
    // if (snapshot.connectionState == ConnectionState.done) {
    //   // return Obx(
    //   //   () => GetMaterialApp(
    //   //     title: "Chatkuy",
    //   //     initialRoute: authC.isAuth.isTrue ? Routes.HOME : Routes.LOGIN,
    //   //     getPages: AppPages.routes,
    //   //   ),
    //   // );

    //     },
  }
}
