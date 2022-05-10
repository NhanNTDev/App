part of 'complete_task_bloc.dart';

enum CompleteTaskStatus { initial, success, failure }

class CompleteTaskState extends Equatable {
  const CompleteTaskState({
    this.status = CompleteTaskStatus.initial,
    this.collectOrders = const <CollectDestination>[],
    this.hasReachedMax = false,
  });

  final CompleteTaskStatus status;
  final List<CollectDestination> collectOrders;
  final bool hasReachedMax;

  CompleteTaskState copyWith({
    CompleteTaskStatus? status,
    List<CollectDestination>? collectOrders,
    bool? hasReachedMax,
  }) {
    return CompleteTaskState(
      status: status ?? this.status,
      collectOrders: collectOrders ?? this.collectOrders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''CompleteTaskState { status: $status, hasReachedMax: $hasReachedMax, farms: ${collectOrders.length} }''';
  }

  @override
  List<Object> get props => [status, collectOrders, hasReachedMax];
}
