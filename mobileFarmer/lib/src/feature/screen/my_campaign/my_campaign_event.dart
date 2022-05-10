part of 'my_campaign_bloc.dart';

abstract class MyCampaignEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CampaignFetched extends MyCampaignEvent {}
