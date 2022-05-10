part of 'cancel_order_bloc.dart';

enum CancelFarmOrderStatus { initial, success, failure }

class CancelFarmOrderState extends Equatable {
  const CancelFarmOrderState({
    this.status = CancelFarmOrderStatus.initial,
    this.farmOrders = const <FarmOrder>[],
    this.hasReachedMax = false,
  });

  final CancelFarmOrderStatus status;
  final List<FarmOrder> farmOrders;
  final bool hasReachedMax;

  CancelFarmOrderState copyWith({
    CancelFarmOrderStatus? status,
    List<FarmOrder>? farmOrders,
    bool? hasReachedMax,
  }) {
    return CancelFarmOrderState(
      status: status ?? this.status,
      farmOrders: farmOrders ?? this.farmOrders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''CancelFarmOrderState { status: $status, hasReachedMax: $hasReachedMax, farms: ${farmOrders.length} }''';
  }

  @override
  List<Object> get props => [status, farmOrders, hasReachedMax];
}
