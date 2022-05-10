part of 'need_confirm_order_bloc.dart';

enum NeedConfirmFarmOrderStatus { initial, success, failure }

class NeedConfirmFarmOrderState extends Equatable {
  const NeedConfirmFarmOrderState({
    this.status = NeedConfirmFarmOrderStatus.initial,
    this.farmOrders = const <FarmOrder>[],
    this.hasReachedMax = false,
  });

  final NeedConfirmFarmOrderStatus status;
  final List<FarmOrder> farmOrders;
  final bool hasReachedMax;

  NeedConfirmFarmOrderState copyWith({
    NeedConfirmFarmOrderStatus? status,
    List<FarmOrder>? farmOrders,
    bool? hasReachedMax,
  }) {
    return NeedConfirmFarmOrderState(
      status: status ?? this.status,
      farmOrders: farmOrders ?? this.farmOrders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''NeedConfirmFarmOrderState { status: $status, hasReachedMax: $hasReachedMax, farms: ${farmOrders.length} }''';
  }

  @override
  List<Object> get props => [status, farmOrders, hasReachedMax];
}
