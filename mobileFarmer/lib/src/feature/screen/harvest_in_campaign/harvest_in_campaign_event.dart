part of 'harvest_in_campaign_bloc.dart';

abstract class HarvestInCampaignEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HarvestInCampaignFetched extends HarvestInCampaignEvent {}
