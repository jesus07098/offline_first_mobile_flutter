part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent {
  const BottomNavEvent();
}

class OnTabChange extends BottomNavEvent {
  final int newIndex;

  const OnTabChange(this.newIndex);
}
