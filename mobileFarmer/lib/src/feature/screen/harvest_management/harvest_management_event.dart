part of 'harvest_management_bloc.dart';

abstract class HarvestManagementEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HarvestFetched extends HarvestManagementEvent {}
