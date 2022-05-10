import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:farmer_application/src/feature/model/campaign.dart';
import 'package:farmer_application/src/feature/repository/campaign_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'join_all_campaign_state.dart';
part 'join_all_campaign_event.dart';

const _campaignLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class JoinAllCampaignBloc
    extends Bloc<JoinAllCampaignEvent, JoinAllCampaignState> {
  final String? search;
  final String farmerId;
  JoinAllCampaignBloc({required this.httpClient, this.search, required this.farmerId})
      : super(const JoinAllCampaignState()) {
    on<AllCampaignFetched>(
      _onAllCampaignFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _campaignRepository = CampaignRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onAllCampaignFetched(
      AllCampaignFetched event,
      Emitter<JoinAllCampaignState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == CampaignStatus.initial) {
        final campaigns = await _campaignRepository.fetchAllJoinCampaigns1(i, _campaignLimit, farmerId, '');
        return emit(state.copyWith(
          status: CampaignStatus.success,
          campaigns: campaigns.items,
          hasReachedMax: campaigns.total <= 10 ? true : false,
        ));
      }
      final campaigns = await _campaignRepository.fetchAllJoinCampaigns1(++i, _campaignLimit, farmerId, '');
      campaigns.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: CampaignStatus.success,
          campaigns: List.of(state.campaigns)..addAll(campaigns.items),
          hasReachedMax: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CampaignStatus.failure));
    }
  }
}
