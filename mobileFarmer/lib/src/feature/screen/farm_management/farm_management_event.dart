part of 'farm_management_bloc.dart';

abstract class FarmManagementEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FarmFetched extends FarmManagementEvent {}
