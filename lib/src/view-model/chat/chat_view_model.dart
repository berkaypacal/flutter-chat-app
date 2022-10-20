import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signalr_mobile/src/service/signalr/hubconnection_helper.dart';
import 'package:signalr_mobile/src/service/signalr/signalr_service.dart';

import '../../model/message.dart';
import '../../view/chat/chat_view.dart';

abstract class ChatViewModel extends State<ChatView> {
  final String appBarTitle = "Home";
  final String connectionText = "Connect to chat room";
  final TextEditingController messageController = TextEditingController();
  late final SignalRService signalRService;
  List<Message> messageList = [];
  String connectionId = "";

  @override
  void initState() {
    super.initState();
    signalRService = SignalRService(HubConnectionHelper.instance.hubConnection);
    _startConnection().then((value) {
      _getConnectionId();
      _listenBroadcast();
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  Future<void> _getConnectionId() async {
    connectionId = await signalRService.getConnectionId();
    setState(() {});
  }

  Future<void> _startConnection() async {
    await signalRService.startConnection();
  }

  Future<void> _listenBroadcast() async {
    signalRService.hubConnection.on("BroadcastMessage", (result) {
      if (result!.isNotEmpty) {
        for (var element in result) {
          Message message = Message.fromJson(element as Map<String, dynamic>);
          messageList.add(message);
          setState(() {});
          inspect(message);
        }
      }
    });
  }

  Future<void> sendMessage() async {
    Message message = Message(
      connectionId: connectionId,
      message: messageController.text,
    );
    await signalRService.sendMessage(message);
    messageController.clear();
  }
}
