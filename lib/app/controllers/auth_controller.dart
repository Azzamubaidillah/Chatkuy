import 'package:chatkuy/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;

  Future<void> login() async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.signIn().then((value) => _currentUser = value);

      await _googleSignIn.isSignedIn().then((value) {
        if (value) {
          print(_currentUser);
          isAuth.value = true;
          Get.offAllNamed(Routes.HOME);
        } else {
          print("Tidak berhasil login");
        }
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    Get.toNamed(Routes.LOGIN);
  }
}
