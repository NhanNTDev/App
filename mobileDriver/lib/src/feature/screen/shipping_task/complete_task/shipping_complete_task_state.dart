part of 'shipping_complete_task_bloc.dart';

enum ShippingCompleteTaskStatus { initial, success, failure }

class ShippingCompleteTaskState extends Equatable {
  const ShippingCompleteTaskState({
    this.status = ShippingCompleteTaskStatus.initial,
    this.shippingOrders = const <DeliveryShipping>[],
    this.hasReachedMax = false,
  });

  final ShippingCompleteTaskStatus status;
  final List<DeliveryShipping> shippingOrders;
  final bool hasReachedMax;

  ShippingCompleteTaskState copyWith({
    ShippingCompleteTaskStatus? status,
    List<DeliveryShipping>? shippingOrders,
    bool? hasReachedMax,
  }) {
    return ShippingCompleteTaskState(
      status: status ?? this.status,
      shippingOrders: shippingOrders ?? this.shippingOrders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ShippingCompleteTaskState { status: $status, hasReachedMax: $hasReachedMax, farms: ${shippingOrders.length} }''';
  }

  @override
  List<Object> get props => [status, shippingOrders, hasReachedMax];
}
