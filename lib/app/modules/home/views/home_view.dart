import 'package:chatkuy/app/controllers/auth_controller.dart';
import 'package:chatkuy/app/modules/profile/views/profile_view.dart';
import 'package:chatkuy/app/modules/search/views/search_view.dart';
import 'package:chatkuy/app/routes/app_pages.dart';
import 'package:chatkuy/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  PageController pageController = PageController();
  List<Widget> pages = [HomeView(), SearchView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.chatsStream(authC.user.value.email!),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.active) {
                  var listDocsChats = snapshot1.data!.docs;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: listDocsChats.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder<
                          DocumentSnapshot<Map<String, dynamic>>>(
                        stream: controller
                            .friendStream(listDocsChats[index]["connection"]),
                        builder: (context, snapshot2) {
                          if (snapshot2.connectionState ==
                              ConnectionState.active) {
                            var data = snapshot2.data!.data();
                            return data!["status"] == ""
                                ? ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding,
                                      vertical: kDefaultPadding * 0.75,
                                    ),
                                    onTap: () => controller.goToChatRoom(
                                      "${listDocsChats[index].id}",
                                      authC.user.value.email!,
                                      listDocsChats[index]["connection"],
                                    ),
                                    leading: CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Colors.black26,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: data["photoUrl"] == "noimage"
                                            ? Image.asset(
                                                "assets/logo/noimage.png",
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                "${data["photoUrl"]}",
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    title: Text(
                                      "${data["name"]}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    trailing: listDocsChats[index]
                                                ["total_unread"] ==
                                            0
                                        ? SizedBox()
                                        : Chip(
                                            backgroundColor: kPrimaryColor,
                                            label: Text(
                                              "${listDocsChats[index]["total_unread"]}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                  )
                                : ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 5,
                                    ),
                                    onTap: () => controller.goToChatRoom(
                                      "${listDocsChats[index].id}",
                                      authC.user.value.email!,
                                      listDocsChats[index]["connection"],
                                    ),
                                    leading: CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Colors.black26,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: data["photoUrl"] == "noimage"
                                            ? Image.asset(
                                                "assets/logo/noimage.png",
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                "${data["photoUrl"]}",
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    title: Text(
                                      "${data["name"]}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${data["status"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    trailing: listDocsChats[index]
                                                ["total_unread"] ==
                                            0
                                        ? SizedBox()
                                        : Chip(
                                            backgroundColor: kPrimaryColor,
                                            label: Text(
                                              "${listDocsChats[index]["total_unread"]}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                  );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.SEARCH),
        child: Icon(
          Icons.search,
          size: 30,
        ),
        backgroundColor: kPrimaryColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search Friend",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Chats"),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.info_outline))],
    );
  }
}
