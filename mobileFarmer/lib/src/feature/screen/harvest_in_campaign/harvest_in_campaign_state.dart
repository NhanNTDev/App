part of 'harvest_in_campaign_bloc.dart';

enum HarvestInCampaignStatus { initial, success, failure }

class HarvestInCampaignState extends Equatable {
  const HarvestInCampaignState({
    this.status = HarvestInCampaignStatus.initial,
    this.harvestsInCampaign = const <HarvestInCampaign>[],
    this.hasReachedMax = false,
  });

  final HarvestInCampaignStatus status;
  final List<HarvestInCampaign> harvestsInCampaign;
  final bool hasReachedMax;

  HarvestInCampaignState copyWith({
    HarvestInCampaignStatus? status,
    List<HarvestInCampaign>? harvestsInCampaign,
    bool? hasReachedMax,
  }) {
    return HarvestInCampaignState(
      status: status ?? this.status,
      harvestsInCampaign: harvestsInCampaign ?? this.harvestsInCampaign,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''HarvestInCampaignState { status: $status, hasReachedMax: $hasReachedMax, harvests: ${harvestsInCampaign.length} }''';
  }

  @override
  List<Object> get props => [status, harvestsInCampaign, hasReachedMax];
}
