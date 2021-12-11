import 'package:chatkuy/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final List<Widget> myChats = List.generate(
    20,
    (index) => ListTile(
        onTap: () => Get.toNamed(Routes.CHAT_ROOM),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black26,
          child: Image.asset(
            "assets/logo/noimage.png",
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          "Orang ke ${index + 1}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text("chatnya orang ke ${index + 1}",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            )),
        trailing: Chip(label: Text("3"))),
  ).reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Material(
          elevation: 3,
          child: Container(
            margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Chatkuy",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () => Get.toNamed(Routes.PROFILE),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.person,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: myChats.length,
              itemBuilder: (context, index) => myChats[index]),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.SEARCH),
        child: Icon(Icons.message_rounded),
      ),
    );
  }
}
