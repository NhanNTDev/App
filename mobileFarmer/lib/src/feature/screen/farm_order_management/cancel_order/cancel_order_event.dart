part of 'cancel_order_bloc.dart';

abstract class CancelFarmOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CancelFarmOrderFetched extends CancelFarmOrderEvent {}
