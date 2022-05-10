part of 'processing_task_bloc.dart';

enum ProcessingTaskStatus { initial, success, failure }

class ProcessingTaskState extends Equatable {
  const ProcessingTaskState({
    this.status = ProcessingTaskStatus.initial,
    this.collectOrders = const <CollectDestination>[],
    this.hasReachedMax = false,
  });

  final ProcessingTaskStatus status;
  final List<CollectDestination> collectOrders;
  final bool hasReachedMax;

  ProcessingTaskState copyWith({
    ProcessingTaskStatus? status,
    List<CollectDestination>? collectOrders,
    bool? hasReachedMax,
  }) {
    return ProcessingTaskState(
      status: status ?? this.status,
      collectOrders: collectOrders ?? this.collectOrders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ProcessingTaskState { status: $status, hasReachedMax: $hasReachedMax, farms: ${collectOrders.length} }''';
  }

  @override
  List<Object> get props => [status, collectOrders, hasReachedMax];
}
