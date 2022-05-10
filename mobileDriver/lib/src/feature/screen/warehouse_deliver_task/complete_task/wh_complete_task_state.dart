part of 'wh_complete_task_bloc.dart';


enum WhCompleteTaskStatus { initial, success, failure }

class WhCompleteTaskState extends Equatable {
  const WhCompleteTaskState({
    this.status = WhCompleteTaskStatus.initial,
    this.warehouseDeliverOrders = const <WarehouseDeliverOrder>[],
    this.hasReachedMax = false,
  });

  final WhCompleteTaskStatus status;
  final List<WarehouseDeliverOrder> warehouseDeliverOrders;
  final bool hasReachedMax;

  WhCompleteTaskState copyWith({
    WhCompleteTaskStatus? status,
    List<WarehouseDeliverOrder>? warehouseDeliverOrders,
    bool? hasReachedMax,
  }) {
    return WhCompleteTaskState(
      status: status ?? this.status,
      warehouseDeliverOrders: warehouseDeliverOrders ?? this.warehouseDeliverOrders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''WhCompleteTaskState { status: $status, hasReachedMax: $hasReachedMax, farms: ${warehouseDeliverOrders.length} }''';
  }

  @override
  List<Object> get props => [status, warehouseDeliverOrders, hasReachedMax];
}
