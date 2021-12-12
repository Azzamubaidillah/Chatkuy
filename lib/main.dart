import 'package:chatkuy/app/controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/error_screen.dart';
import 'app/utils/loading_screen.dart';
import 'app/utils/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          return GetMaterialApp(
            title: "Chatkuy",
            initialRoute: Routes.PROFILE,
            getPages: AppPages.routes,
          );

          // return FutureBuilder(
          //     future: Future.delayed(Duration(seconds: 3)),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         return Obx(
          //           () => GetMaterialApp(
          //             title: "Chatkuy",
          //             initialRoute: authC.isSkipIntro.isTrue
          //                 ? authC.isAuth.isTrue
          //                     ? Routes.HOME
          //                     : Routes.LOGIN
          //                 : Routes.INTRODUCTION,
          //             getPages: AppPages.routes,
          //           ),
          //         );
          //       }
          //       return SplashScreen();
          //     });
        }

        //otherwise, show something whilst waiting for initialization to complete
        return LoadingScreen();
      },
    );
  }
}
