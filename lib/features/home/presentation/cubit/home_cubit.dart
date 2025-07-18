import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late TabController _tabController;

  HomeCubit() : super(const HomeInitial());

  void initializeTabController(TickerProvider vsync) {
    _tabController = TabController(length: 2, vsync: vsync);
    _tabController.addListener(_onTabChanged);
    emit(const HomeTabChanged(0));
  }

  void setTabIndex(int index) {
    if (_tabController.index != index) {
      _tabController.animateTo(index);
    }
    emit(HomeTabChanged(index));
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      emit(HomeTabChanged(_tabController.index));
    }
  }

  TabController get tabController => _tabController;

  @override
  Future<void> close() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    return super.close();
  }
}
