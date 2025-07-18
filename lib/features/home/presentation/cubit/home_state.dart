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
  final int tabIndex;

  const HomeTabChanged(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}
