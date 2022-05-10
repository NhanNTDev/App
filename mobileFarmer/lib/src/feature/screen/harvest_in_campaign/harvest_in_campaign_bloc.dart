import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:farmer_application/src/feature/model/harvest.dart';
import 'package:farmer_application/src/feature/model/harvest_in_campaign.dart';
import 'package:farmer_application/src/feature/repository/harvest_in_campaign_repository.dart';
import 'package:farmer_application/src/feature/repository/harvest_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'harvest_in_campaign_event.dart';

part 'harvest_in_campaign_state.dart';

const _harvestLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HarvestInCampaignBloc
    extends Bloc<HarvestInCampaignEvent, HarvestInCampaignState> {
  final int campaignId;
  final int farmId;
  HarvestInCampaignBloc({required this.httpClient, required this.campaignId, required this.farmId})
      : super(const HarvestInCampaignState()) {
    on<HarvestInCampaignFetched>(
      _onHarvestInCampaignFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _harvestInCampaignRepository = HarvestInCampaignRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onHarvestInCampaignFetched(
      HarvestInCampaignFetched event,
      Emitter<HarvestInCampaignState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == HarvestInCampaignStatus.initial) {
        final harvestsInCampaign =
        await _harvestInCampaignRepository.getListHarvestsInCampaign(i, _harvestLimit, campaignId,farmId);
        return emit(state.copyWith(
          status: HarvestInCampaignStatus.success,
          harvestsInCampaign: harvestsInCampaign.items,
          hasReachedMax: harvestsInCampaign.total <= 10 ? true : false,
        ));
        // }
      }
      final harvestsInCampaign =
      await _harvestInCampaignRepository.getListHarvestsInCampaign(++i, _harvestLimit, campaignId,farmId);
      harvestsInCampaign.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: HarvestInCampaignStatus.success,
          harvestsInCampaign: List.of(state.harvestsInCampaign)..addAll(harvestsInCampaign.items),
          hasReachedMax: false,
        ),
      );
      // }
    } catch (_) {
      emit(state.copyWith(status: HarvestInCampaignStatus.failure));
    }
  }
}
