import 'package:signalr_mobile/src/service/signalr/signalr_function_enum.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../model/message.dart';

class SignalRService {
  final HubConnection hubConnection;

  SignalRService(this.hubConnection);

  Future<void> startConnection() async {
    await hubConnection.start()?.catchError((error) {});

    hubConnection.onclose(({error}) {});
  }

  Future<void> stopConnection() async {
    await hubConnection.stop();
  }

  Future<void> sendMessage(Message message) async {
    await hubConnection.invoke(SignalrFunctionEnum.SendMessage.name, args: <Message>[message]);
  }

  Future<String> getConnectionId() async {
    var connectionIdResponse = await hubConnection.invoke(SignalrFunctionEnum.GetConnectionId.name);
    if (connectionIdResponse != null) {
      return connectionIdResponse.toString();
    }
    return "";
  }
}
