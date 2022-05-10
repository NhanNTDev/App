part of 'my_campaign_bloc.dart';

enum CampaignStatus { initial, success, failure }

class MyCampaignState extends Equatable {
  const MyCampaignState({
    this.status = CampaignStatus.initial,
    this.campaigns = const <JoinedCampaign>[],
    this.hasReachedMax = false,
  });

  final CampaignStatus status;
  final List<JoinedCampaign> campaigns;
  final bool hasReachedMax;

  MyCampaignState copyWith({
    CampaignStatus? status,
    List<JoinedCampaign>? campaigns,
    bool? hasReachedMax,
  }) {
    return MyCampaignState(
      status: status ?? this.status,
      campaigns: campaigns ?? this.campaigns,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''MyCampaignState { status: $status, hasReachedMax: $hasReachedMax, farms: ${campaigns.length} }''';
  }

  @override
  List<Object> get props => [status, campaigns, hasReachedMax];
}
