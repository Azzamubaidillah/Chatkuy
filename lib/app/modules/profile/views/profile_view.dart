import 'package:chatkuy/app/controllers/auth_controller.dart';
import 'package:chatkuy/app/routes/app_pages.dart';
import 'package:chatkuy/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(LineAwesomeIcons.angle_left,
                      size: kDefaultPadding * 1.3),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  width: 120,
                  height: 120,
                  child: authC.user.value.photoUrl == "noimage"
                      ? ClipRRect(
                          child: Image.asset("assets/logo/noimage.png",
                              fit: BoxFit.cover),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            authC.user.value.photoUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Icon(
                  LineAwesomeIcons.sun,
                  size: kDefaultPadding * 2,
                  color: isDarkMode
                      ? kContentColorLightTheme
                      : kContentColorDarkTheme,
                ),
              ]),
          Container(
            child: Column(
              children: [
                Obx(
                  () => Text(
                    "${authC.user.value.name}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  "${authC.user.value.email}",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  ProfileListView(
                    authC: authC,
                    isDarkMode: isDarkMode,
                    text: "Update Status",
                    icon: Icon(LineAwesomeIcons.user_astronaut),
                    route: () => Get.toNamed(Routes.UPDATE_STATUS),
                  ),
                  ProfileListView(
                    authC: authC,
                    isDarkMode: isDarkMode,
                    text: "Change Profile",
                    icon: Icon(LineAwesomeIcons.cog),
                    route: () => Get.toNamed(Routes.CHANGE_PROFILE),
                  ),
                  ProfileListView(
                    authC: authC,
                    isDarkMode: isDarkMode,
                    text: "Info",
                    icon: Icon(LineAwesomeIcons.question_circle),
                    route: () => Get.toNamed(Routes.INFO),
                  ),
                  ProfileListView(
                    authC: authC,
                    isDarkMode: isDarkMode,
                    text: "Logout",
                    icon: Icon(LineAwesomeIcons.alternate_sign_out),
                    route: () => authC.logout(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class ProfileListView extends StatelessWidget {
  const ProfileListView({
    Key? key,
    required this.authC,
    required this.isDarkMode,
    required this.text,
    required this.icon,
    required this.route,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final VoidCallback route;
  final AuthController authC;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          kDefaultPadding, kDefaultPadding, kDefaultPadding, 5),
      child: ListTile(
        onTap: route,
        leading: icon,
        title: Text(text),
        trailing: Icon(LineAwesomeIcons.angle_right),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isDarkMode ? kBackgroundDark : kBackgroundLight),
    );
  }
}

//               onPressed: () => authC.logout(),