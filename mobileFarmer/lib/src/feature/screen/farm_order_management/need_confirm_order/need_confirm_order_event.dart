part of 'need_confirm_order_bloc.dart';

abstract class NeedConfirmFarmOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NeedConfirmFarmOrderFetched extends NeedConfirmFarmOrderEvent {}
