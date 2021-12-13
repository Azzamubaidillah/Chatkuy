import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  var isShowEmoji = false.obs;
  late FocusNode focusNode;
  late TextEditingController chatC;

  void addEmojiToChat(Emoji emoji) {
    chatC.text = chatC.text + emoji.emoji;
  }

  void deleteEmoji() {
    chatC.text = chatC.text.substring(0, chatC.text.length - 2);
  }

  @override
  void onInit() {
    chatC = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
  }

  @override
  void onClose() {
    focusNode.dispose();
    chatC.dispose();
    super.onClose();
  }
}
