import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:signalr_mobile/src/service/signalr/logger_helper.dart';
import 'package:signalr_netcore/signalr_client.dart';

class HubConnectionHelper {
  static HubConnectionHelper? _instance;
  late final HubConnection hubConnection;
  final String serverUrl = dotenv.env['SIGNALR_URL'] ?? "";

  static HubConnectionHelper get instance {
    _instance ??= HubConnectionHelper._();
    return _instance!;
  }

  HubConnectionHelper._() {
    final httpOptions = HttpConnectionOptions(
      logger: LoggerHelper.instance.transporterLogger,
    );

    hubConnection = HubConnectionBuilder()
        .withUrl(
          serverUrl,
          options: httpOptions,
        )
        .configureLogging(LoggerHelper.instance.hubProtocolLogger)
        .build();
  }
}
