part of 'processing_order_bloc.dart';

enum ProcessingFarmOrderStatus { initial, success, failure }

class ProcessingFarmOrderState extends Equatable {
  const ProcessingFarmOrderState({
    this.status = ProcessingFarmOrderStatus.initial,
    this.farmOrders = const <FarmOrder>[],
    this.hasReachedMax = false,
  });

  final ProcessingFarmOrderStatus status;
  final List<FarmOrder> farmOrders;
  final bool hasReachedMax;

  ProcessingFarmOrderState copyWith({
    ProcessingFarmOrderStatus? status,
    List<FarmOrder>? farmOrders,
    bool? hasReachedMax,
  }) {
    return ProcessingFarmOrderState(
      status: status ?? this.status,
      farmOrders: farmOrders ?? this.farmOrders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ProcessingFarmOrderState { status: $status, hasReachedMax: $hasReachedMax, farms: ${farmOrders.length} }''';
  }

  @override
  List<Object> get props => [status, farmOrders, hasReachedMax];
}
