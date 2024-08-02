import 'package:flutter/material.dart';
import 'package:maybe_app/config/helpers/get_yes_no_answer.dart';
import 'package:maybe_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollControler = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(text: 'Hola Amor!', fromWho: FromWho.me),
    Message(text: 'Ya regresaste del trabajo?', fromWho: FromWho.me),
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);

    if (text.endsWith('?')) {
      await herReplay();
    }

    notifyListeners();
    moveScrollToBottom();
  }

  herReplay() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messageList.add(herMessage);
  }

  void moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollControler.animateTo(
      chatScrollControler.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
