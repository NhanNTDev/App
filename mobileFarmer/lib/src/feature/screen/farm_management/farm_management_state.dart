part of 'farm_management_bloc.dart';

enum FarmStatus { initial, success, failure }

class FarmManagementState extends Equatable {
  const FarmManagementState({
    this.status = FarmStatus.initial,
    this.farms = const <Farm>[],
    this.hasReachedMax = false,
  });

  final FarmStatus status;
  final List<Farm> farms;
  final bool hasReachedMax;

  FarmManagementState copyWith({
    FarmStatus? status,
    List<Farm>? farms,
    bool? hasReachedMax,
  }) {
    return FarmManagementState(
      status: status ?? this.status,
      farms: farms ?? this.farms,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''FarmManagementState { status: $status, hasReachedMax: $hasReachedMax, farms: ${farms.length} }''';
  }

  @override
  List<Object> get props => [status, farms, hasReachedMax];
}
