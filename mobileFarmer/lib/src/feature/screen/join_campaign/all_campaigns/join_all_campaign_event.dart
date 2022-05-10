part of 'join_all_campaign_bloc.dart';

abstract class JoinAllCampaignEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AllCampaignFetched extends JoinAllCampaignEvent {}
