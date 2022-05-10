part of 'join_event_campaign_bloc.dart';

enum CampaignStatus { initial, success, failure }

class JoinEventCampaignState extends Equatable {
  const JoinEventCampaignState({
    this.status = CampaignStatus.initial,
    this.campaigns = const <CampaignCanJoin>[],
    this.hasReachedMax = false,
  });

  final CampaignStatus status;
  final List<CampaignCanJoin> campaigns;
  final bool hasReachedMax;

  JoinEventCampaignState copyWith({
    CampaignStatus? status,
    List<CampaignCanJoin>? campaigns,
    bool? hasReachedMax,
  }) {
    return JoinEventCampaignState(
      status: status ?? this.status,
      campaigns: campaigns ?? this.campaigns,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''JoinEventCampaignState { status: $status, hasReachedMax: $hasReachedMax, farms: ${campaigns.length} }''';
  }

  @override
  List<Object> get props => [status, campaigns, hasReachedMax];
}
