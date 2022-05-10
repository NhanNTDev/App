part of 'join_all_campaign_bloc.dart';

enum CampaignStatus { initial, success, failure }

class JoinAllCampaignState extends Equatable {
  const JoinAllCampaignState({
    this.status = CampaignStatus.initial,
    this.campaigns = const <CampaignCanJoin>[],
    this.hasReachedMax = false,
  });

  final CampaignStatus status;
  final List<CampaignCanJoin> campaigns;
  final bool hasReachedMax;

  JoinAllCampaignState copyWith({
    CampaignStatus? status,
    List<CampaignCanJoin>? campaigns,
    bool? hasReachedMax,
  }) {
    return JoinAllCampaignState(
      status: status ?? this.status,
      campaigns: campaigns ?? this.campaigns,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''JoinAllCampaignState { status: $status, hasReachedMax: $hasReachedMax, farms: ${campaigns.length} }''';
  }

  @override
  List<Object> get props => [status, campaigns, hasReachedMax];
}
