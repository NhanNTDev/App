part of 'harvest_in_farm_bloc.dart';

enum HarvestInFarmStatus { initial, success, failure }

class HarvestInFarmState extends Equatable {
  const HarvestInFarmState({
    this.status = HarvestInFarmStatus.initial,
    this.harvestsInFarm = const <Harvest>[],
    this.hasReachedMax = false,
  });

  final HarvestInFarmStatus status;
  final List<Harvest> harvestsInFarm;
  final bool hasReachedMax;

  HarvestInFarmState copyWith({
    HarvestInFarmStatus? status,
    List<Harvest>? harvestsInFarm,
    bool? hasReachedMax,
  }) {
    return HarvestInFarmState(
      status: status ?? this.status,
      harvestsInFarm: harvestsInFarm ?? this.harvestsInFarm,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''HarvestInFarmState { status: $status, hasReachedMax: $hasReachedMax, farms: ${harvestsInFarm.length} }''';
  }

  @override
  List<Object> get props => [status, harvestsInFarm, hasReachedMax];
}
