part of 'bluetooth_bloc.dart';

class BluetoothState extends Equatable {
  final BluetoothStatusConnection status;

  const BluetoothState({required this.status});

  @override
  List<Object> get props => [status];
}

class BluetoothDisconnectState extends BluetoothState {
  const BluetoothDisconnectState()
      : super(status: BluetoothStatusConnection.disconnect);
}

class BluetoothChangeState extends BluetoothState {
  const BluetoothChangeState({required BluetoothStatusConnection status})
      : super(status: status);
}
