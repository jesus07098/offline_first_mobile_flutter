part of 'network_bloc.dart';

class NetworkState extends Equatable {
  const NetworkState({
    this.isConnected = false,
  });

  final bool isConnected;

  NetworkState copyWith({
    bool? isConnected,
  }) {
    return NetworkState(
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object> get props => [isConnected];
}
