part of 'shipping_processing_task_bloc.dart';

enum ShippingProcessingTaskStatus { initial, success, failure }

class ShippingProcessingTaskState extends Equatable {
  const ShippingProcessingTaskState({
    this.status = ShippingProcessingTaskStatus.initial,
    this.shippingOrders = const <DeliveryShipping>[],
    this.hasReachedMax = false,
  });

  final ShippingProcessingTaskStatus status;
  final List<DeliveryShipping> shippingOrders;
  final bool hasReachedMax;

  ShippingProcessingTaskState copyWith({
    ShippingProcessingTaskStatus? status,
    List<DeliveryShipping>? shippingOrders,
    bool? hasReachedMax,
  }) {
    return ShippingProcessingTaskState(
      status: status ?? this.status,
      shippingOrders: shippingOrders ?? this.shippingOrders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ShippingProcessingTaskState { status: $status, hasReachedMax: $hasReachedMax, farms: ${shippingOrders
        .length} }''';
  }

  @override
  List<Object> get props => [status, shippingOrders, hasReachedMax];
}
