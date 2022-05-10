part of 'confirmed_order_bloc.dart';

abstract class ConfirmedFarmOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ConfirmedFarmOrderFetched extends ConfirmedFarmOrderEvent {}
