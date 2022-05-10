part of 'shipping_cancel_task_bloc.dart';

enum ShippingCancelTaskStatus { initial, success, failure }

class ShippingCancelTaskState extends Equatable {
  const ShippingCancelTaskState({
    this.status = ShippingCancelTaskStatus.initial,
    this.shippingOrders = const <DeliveryShipping>[],
    this.hasReachedMax = false,
  });

  final ShippingCancelTaskStatus status;
  final List<DeliveryShipping> shippingOrders;
  final bool hasReachedMax;

  ShippingCancelTaskState copyWith({
    ShippingCancelTaskStatus? status,
    List<DeliveryShipping>? shippingOrders,
    bool? hasReachedMax,
  }) {
    return ShippingCancelTaskState(
      status: status ?? this.status,
      shippingOrders: shippingOrders ?? this.shippingOrders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ShippingCancelTaskState { status: $status, hasReachedMax: $hasReachedMax, farms: ${shippingOrders.length} }''';
  }

  @override
  List<Object> get props => [status, shippingOrders, hasReachedMax];
}
