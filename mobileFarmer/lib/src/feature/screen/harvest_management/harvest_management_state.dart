part of 'harvest_management_bloc.dart';

enum HarvestStatus { initial, success, failure }

class HarvestManagementState extends Equatable {
  const HarvestManagementState({
    this.status = HarvestStatus.initial,
    this.harvests = const <Harvest>[],
    this.hasReachedMax = false,
  });

  final HarvestStatus status;
  final List<Harvest> harvests;
  final bool hasReachedMax;

  HarvestManagementState copyWith({
    HarvestStatus? status,
    List<Harvest>? harvests,
    bool? hasReachedMax,
  }) {
    return HarvestManagementState(
      status: status ?? this.status,
      harvests: harvests ?? this.harvests,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''HarvestManagementState { status: $status, hasReachedMax: $hasReachedMax, farms: ${harvests.length} }''';
  }

  @override
  List<Object> get props => [status, harvests, hasReachedMax];
}
