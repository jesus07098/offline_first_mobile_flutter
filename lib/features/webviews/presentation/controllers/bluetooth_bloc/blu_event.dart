part of 'bluetooth_bloc.dart';

abstract class BluEvent extends Equatable {
  const BluEvent();

  @override
  List<Object> get props => [];
}

class BluStatusEvent extends BluEvent {
  final BluetoothStatusConnection status;

  const BluStatusEvent({required this.status});
}
