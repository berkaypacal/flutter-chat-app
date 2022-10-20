import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:signalr_mobile/src/model/message.dart';
import 'package:signalr_mobile/src/view-model/chat/chat_view_model.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ChatViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messageList.length,
              itemBuilder: (BuildContext context, int index) {
                String messageConnectionId = messageList[index].connectionId ?? "";
                return _ChatBubbleComponent(
                  model: messageList[index],
                  connectionId: connectionId,
                  messageConnectionId: messageConnectionId,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: _ChatTextFieldComponent(
              messageController: messageController,
              onPressed: () {
                sendMessage();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubbleComponent extends StatelessWidget {
  const _ChatBubbleComponent({
    Key? key,
    required this.model,
    required this.connectionId,
    required this.messageConnectionId,
  }) : super(key: key);

  final Message model;
  final String connectionId;
  final String messageConnectionId;

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      text: model.message ?? "",
      color: const Color(0xFF1B97F3),
      tail: true,
      isSender: connectionId == messageConnectionId ? true : false,
      textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
    );
  }
}

class _ChatTextFieldComponent extends StatelessWidget {
  const _ChatTextFieldComponent({
    Key? key,
    required this.messageController,
    required this.onPressed,
  }) : super(key: key);
  final void Function() onPressed;
  final TextEditingController messageController;
  final String placeholder = "Send message";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            controller: messageController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: placeholder,
            ),
          ),
        ),
        IconButton(onPressed: () => onPressed.call(), icon: const Icon(Icons.send))
      ],
    );
  }
}
