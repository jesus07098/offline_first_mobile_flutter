import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../presentation/blocs/network/network_bloc.dart';

class NetworkManager {
  static void observeNetwork() async {
    InternetConnection().onStatusChange.listen((InternetStatus status) {
      try {
        switch (status) {
          case InternetStatus.connected:
            NetworkBloc().add(NetworkNotify(isConnected: true));
            break;
          case InternetStatus.disconnected:
            NetworkBloc().add(NetworkNotify());
            break;
        }
      } catch (e) {
        NetworkBloc().add(NetworkNotify());
      }
    });
  }
}
