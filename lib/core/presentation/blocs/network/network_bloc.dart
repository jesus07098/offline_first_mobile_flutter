import 'package:offline_first/core/utils/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc._() : super(const NetworkState()) {
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notifyStatus);
  }

  static final NetworkBloc _instance = NetworkBloc._();

  factory NetworkBloc() => _instance;

  void _observe(NetworkObserve event, Emitter<NetworkState> emit) {
    NetworkManager.observeNetwork();
  }

  void _notifyStatus(NetworkNotify event, Emitter<NetworkState> emit) {
    event.isConnected
        ? emit(state.copyWith(isConnected: true))
        : emit(state.copyWith(isConnected: false));
  }
}
