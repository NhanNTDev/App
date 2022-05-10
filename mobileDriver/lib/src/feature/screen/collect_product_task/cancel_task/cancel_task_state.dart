part of 'cancel_task_bloc.dart';

enum CancelTaskStatus { initial, success, failure }

class CancelTaskState extends Equatable {
  const CancelTaskState({
    this.status = CancelTaskStatus.initial,
    this.collectOrders = const <CollectDestination>[],
    this.hasReachedMax = false,
  });

  final CancelTaskStatus status;
  final List<CollectDestination> collectOrders;
  final bool hasReachedMax;

  CancelTaskState copyWith({
    CancelTaskStatus? status,
    List<CollectDestination>? collectOrders,
    bool? hasReachedMax,
  }) {
    return CancelTaskState(
      status: status ?? this.status,
      collectOrders: collectOrders ?? this.collectOrders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''CancelTaskState { status: $status, hasReachedMax: $hasReachedMax, farms: ${collectOrders.length} }''';
  }

  @override
  List<Object> get props => [status, collectOrders, hasReachedMax];
}
