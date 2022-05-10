part of 'shipping_processing_task_bloc.dart';

abstract class ShippingProcessingTaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ShippingProcessingFetched extends ShippingProcessingTaskEvent {}
