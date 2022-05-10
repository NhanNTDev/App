part of 'join_weekly_campaign_bloc.dart';

enum CampaignStatus { initial, success, failure }

class JoinWeeklyCampaignState extends Equatable {
  const JoinWeeklyCampaignState({
    this.status = CampaignStatus.initial,
    this.campaigns = const <CampaignCanJoin>[],
    this.hasReachedMax = false,
  });

  final CampaignStatus status;
  final List<CampaignCanJoin> campaigns;
  final bool hasReachedMax;

  JoinWeeklyCampaignState copyWith({
    CampaignStatus? status,
    List<CampaignCanJoin>? campaigns,
    bool? hasReachedMax,
  }) {
    return JoinWeeklyCampaignState(
      status: status ?? this.status,
      campaigns: campaigns ?? this.campaigns,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''JoinWeeklyCampaignState { status: $status, hasReachedMax: $hasReachedMax, farms: ${campaigns.length} }''';
  }

  @override
  List<Object> get props => [status, campaigns, hasReachedMax];
}
