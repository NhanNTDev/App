import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:farmer_application/src/feature/model/harvest.dart';
import 'package:farmer_application/src/feature/repository/harvest_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'harvest_in_farm_event.dart';
part 'harvest_in_farm_state.dart';

const _harvestsInFarmLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HarvestInFarmBloc extends Bloc<HarvestInFarmEvent, HarvestInFarmState> {
  final int farmId;

  HarvestInFarmBloc({required this.httpClient, required this.farmId})
      : super(const HarvestInFarmState()) {
    on<HarvestInFarmFetched>(
      _onHarvestInFarmFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _harvestRepository = HarvestRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onHarvestInFarmFetched(
    HarvestInFarmFetched event,
    Emitter<HarvestInFarmState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == HarvestInFarmStatus.initial) {
        final harvestsInFarm = await _harvestRepository.fetchAllHarvestsByFarm(i, _harvestsInFarmLimit, farmId);
        return emit(state.copyWith(
          status: HarvestInFarmStatus.success,
          harvestsInFarm: harvestsInFarm.items,
          hasReachedMax: harvestsInFarm.total <= 10 ? true : false,
        ));
      }
      final harvestsInFarm = await _harvestRepository.fetchAllHarvestsByFarm(++i, _harvestsInFarmLimit, farmId);
      harvestsInFarm.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: HarvestInFarmStatus.success,
                harvestsInFarm: List.of(state.harvestsInFarm)
                  ..addAll(harvestsInFarm.items),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: HarvestInFarmStatus.failure));
    }
  }
}
