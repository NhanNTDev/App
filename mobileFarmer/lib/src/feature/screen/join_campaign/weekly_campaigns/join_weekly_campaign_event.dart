part of 'join_weekly_campaign_bloc.dart';

abstract class JoinWeeklyCampaignEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WeeklyCampaignFetched extends JoinWeeklyCampaignEvent {}
