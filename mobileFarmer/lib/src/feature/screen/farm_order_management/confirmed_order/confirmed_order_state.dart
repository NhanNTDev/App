part of 'confirmed_order_bloc.dart';

enum ConfirmedFarmOrderStatus { initial, success, failure }

class ConfirmedFarmOrderState extends Equatable {
  const ConfirmedFarmOrderState({
    this.status = ConfirmedFarmOrderStatus.initial,
    this.farmOrders = const <FarmOrder>[],
    this.hasReachedMax = false,
  });

  final ConfirmedFarmOrderStatus status;
  final List<FarmOrder> farmOrders;
  final bool hasReachedMax;

  ConfirmedFarmOrderState copyWith({
    ConfirmedFarmOrderStatus? status,
    List<FarmOrder>? farmOrders,
    bool? hasReachedMax,
  }) {
    return ConfirmedFarmOrderState(
      status: status ?? this.status,
      farmOrders: farmOrders ?? this.farmOrders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ConfirmedFarmOrderState { status: $status, hasReachedMax: $hasReachedMax, farms: ${farmOrders.length} }''';
  }

  @override
  List<Object> get props => [status, farmOrders, hasReachedMax];
}
