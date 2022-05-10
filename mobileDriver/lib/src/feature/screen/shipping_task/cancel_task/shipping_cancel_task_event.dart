part of 'shipping_cancel_task_bloc.dart';

abstract class ShippingCancelTaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ShippingCancelFetched extends ShippingCancelTaskEvent {}
