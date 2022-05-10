part of 'complete_order_bloc.dart';

enum CompleteFarmOrderStatus { initial, success, failure }

class CompleteFarmOrderState extends Equatable {
  const CompleteFarmOrderState({
    this.status = CompleteFarmOrderStatus.initial,
    this.farmOrders = const <FarmOrder>[],
    this.hasReachedMax = false,
  });

  final CompleteFarmOrderStatus status;
  final List<FarmOrder> farmOrders;
  final bool hasReachedMax;

  CompleteFarmOrderState copyWith({
    CompleteFarmOrderStatus? status,
    List<FarmOrder>? farmOrders,
    bool? hasReachedMax,
  }) {
    return CompleteFarmOrderState(
      status: status ?? this.status,
      farmOrders: farmOrders ?? this.farmOrders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''CompleteFarmOrderState { status: $status, hasReachedMax: $hasReachedMax, farms: ${farmOrders.length} }''';
  }

  @override
  List<Object> get props => [status, farmOrders, hasReachedMax];
}
