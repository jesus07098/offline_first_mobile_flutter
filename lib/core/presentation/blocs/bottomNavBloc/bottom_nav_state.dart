part of 'bottom_nav_bloc.dart';

class BottomNavState extends Equatable {
  final int index;

  const BottomNavState({this.index = 0});

  BottomNavState copyWith({int? index}) => BottomNavState(
        index: index ?? this.index,
      );

  @override
  List<Object?> get props => [index];
}
