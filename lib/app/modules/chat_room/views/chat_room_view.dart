import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        leadingWidth: 100,
        leading: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 5),
              Icon(Icons.arrow_back),
              SizedBox(width: 5),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: Image.asset("assets/logo/noimage.png"),
              ),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lorem Ipsum",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text('ini statusnya...',
                style: TextStyle(
                  fontSize: 13,
                ))
          ],
        ),
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            child: ListView(
              children: [
                itemChat(isSender: true),
                itemChat(isSender: false),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.emoji_emotions_outlined),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Material(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue[500],
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class itemChat extends StatelessWidget {
  const itemChat({
    Key? key,
    required this.isSender,
  }) : super(key: key);

  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSender ? Colors.blue[200] : Colors.green[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: isSender ? Radius.circular(15) : Radius.circular(0),
                bottomRight:
                    isSender ? Radius.circular(0) : Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Text("Aku sayang kamu"),
          ),
          SizedBox(height: 5),
          Text("18:12"),
        ],
      ),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    );
  }
}
