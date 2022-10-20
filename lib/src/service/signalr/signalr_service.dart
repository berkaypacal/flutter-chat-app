import 'package:flutter/foundation.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../model/message.dart';

class SignalRService {
  final HubConnection hubConnection;

  SignalRService(this.hubConnection);

  Future<void> startConnection() async {
    await hubConnection.start()?.catchError((error) {
      if (kDebugMode) {
        print("Connection failed $error");
      }
    });

    hubConnection.onclose(({error}) {
      if (kDebugMode) {
        print("Hub connection stopped automatically");
        if (error != null) print("Error $error");
      }
    });
  }

  Future<void> stopConnection() async {
    await hubConnection.stop();
    if (kDebugMode) {
      print("Hub connection stopped");
    }
  }

  Future<void> sendMessage(Message message) async {
    await hubConnection.invoke("SendMessage", args: <Message>[message]);
  }

  Future<String> getConnectionId() async {
    var connectionIdResponse = await hubConnection.invoke("GetConnectionId");
    if (connectionIdResponse != null) {
      return connectionIdResponse.toString();
    }
    return "";
  }
}
