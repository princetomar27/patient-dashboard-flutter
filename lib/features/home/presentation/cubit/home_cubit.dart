import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/home_tab_enum.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late TabController _tabController;

  HomeCubit() : super(const HomeInitial());

  void initializeTabController(TickerProvider vsync) {
    _tabController = TabController(
      length: HomeTabEnum.values.length,
      vsync: vsync,
    );
    _tabController.addListener(_onTabChanged);
    emit(const HomeTabChanged(HomeTabEnum.dashboard));
  }

  void setTab(HomeTabEnum tab) {
    if (_tabController.index != tab.index) {
      _tabController.animateTo(tab.index);
    }
    emit(HomeTabChanged(tab));
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      final currentTab = HomeTabEnumExtension.fromIndex(_tabController.index);
      emit(HomeTabChanged(currentTab));
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
