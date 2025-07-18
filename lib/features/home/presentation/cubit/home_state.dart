part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeTabChanged extends HomeState {
  final HomeTabEnum currentTab;

  const HomeTabChanged(this.currentTab);

  @override
  List<Object?> get props => [currentTab];
}
