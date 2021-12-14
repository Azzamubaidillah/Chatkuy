import 'package:chatkuy/app/controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/error_screen.dart';
import 'app/utils/loading_screen.dart';
import 'app/utils/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //check errors
        if (snapshot.hasError) {
          return ErrorScreen();
        }

        //one complete, show your applicationId
        if (snapshot.connectionState == ConnectionState.done) {
          // return Obx(
          //   () => GetMaterialApp(
          //     title: "Chatkuy",
          //     initialRoute: authC.isAuth.isTrue ? Routes.HOME : Routes.LOGIN,
          //     getPages: AppPages.routes,
          //   ),
          // );

          return FutureBuilder(
            future: Future.delayed(Duration(seconds: 3)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Obx(
                  () => GetMaterialApp(
                    title: "Chatkuy",
                    initialRoute: authC.isSkipIntro.isTrue
                        ? authC.isAuth.isTrue
                            ? Routes.HOME
                            : Routes.LOGIN
                        : Routes.INTRODUCTION,
                    getPages: AppPages.routes,
                  ),
                );
              }
              return FutureBuilder(
                future: authC.firstInitialized(),
                builder: (context, snapshot) => SplashScreen(),
              );
            },
          );
        }
        //otherwise, show something whilst waiting for initialization to complete
        return LoadingScreen();
      },
    );
  }
}
