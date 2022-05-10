part of 'wh_processing_task_bloc.dart';


enum WhProcessingTaskStatus { initial, success, failure }

class WhProcessingTaskState extends Equatable {
  const WhProcessingTaskState({
    this.status = WhProcessingTaskStatus.initial,
    this.warehouseDeliverOrders = const <WarehouseDeliverOrder>[],
    this.hasReachedMax = false,
  });

  final WhProcessingTaskStatus status;
  final List<WarehouseDeliverOrder> warehouseDeliverOrders;
  final bool hasReachedMax;

  WhProcessingTaskState copyWith({
    WhProcessingTaskStatus? status,
    List<WarehouseDeliverOrder>? warehouseDeliverOrders,
    bool? hasReachedMax,
  }) {
    return WhProcessingTaskState(
      status: status ?? this.status,
      warehouseDeliverOrders: warehouseDeliverOrders ?? this.warehouseDeliverOrders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''WhProcessingTaskState { status: $status, hasReachedMax: $hasReachedMax, farms: ${warehouseDeliverOrders.length} }''';
  }

  @override
  List<Object> get props => [status, warehouseDeliverOrders, hasReachedMax];
}
