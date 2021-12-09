import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/error_page.dart';
import 'app/utils/loading_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //check errors
        if (snapshot.hasError) {
          return ErrorPage();
        }

        //one complete, show your applicationId
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            title: "Chatkuy",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          );
        }

        //otherwise, show something whilst waiting for initialization to complete
        return LoadingPage();
      },
    );
  }
}
