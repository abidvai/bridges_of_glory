import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../model/chat_model.dart';

class MessageController extends GetxController {
  final TextEditingController controller = TextEditingController();

  final RxList<ChatMessageModel> messages = <ChatMessageModel>[
    ChatMessageModel(text: 'Hi! how can i help?', isSender: false),
    ChatMessageModel(
      text: 'Lorem ipsum dolor sit amet consectetur.',
      isSender: true,
    ),
    ChatMessageModel(
      text:
      'Lorem ipsum dolor sit amet consectetur. Rhoncus pretium cursus vestibulum lorem tristique ornare lectus ut erat.',
      isSender: false,
    ),
    ChatMessageModel(
      text: 'Lorem ipsum dolor sit amet consectetur.',
      isSender: false,
    ),
    ChatMessageModel(text: 'Thanks', isSender: true),
    ChatMessageModel(text: 'See you later', isSender: true),
    ChatMessageModel(text: 'Hi! how can i help?', isSender: true),
  ].obs;

}