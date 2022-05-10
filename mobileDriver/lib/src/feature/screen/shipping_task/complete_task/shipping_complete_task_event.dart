part of 'shipping_complete_task_bloc.dart';

abstract class ShippingCompleteTaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ShippingCompleteFetched extends ShippingCompleteTaskEvent {}
