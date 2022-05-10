import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:farmer_application/src/feature/model/harvest.dart';
import 'package:farmer_application/src/feature/repository/harvest_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'harvest_management_event.dart';

part 'harvest_management_state.dart';

const _harvestLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HarvestManagementBloc
    extends Bloc<HarvestManagementEvent, HarvestManagementState> {
  final String? search;
  final String farmerId;

  HarvestManagementBloc(
      {required this.httpClient, this.search, required this.farmerId})
      : super(const HarvestManagementState()) {
    on<HarvestFetched>(
      _onHarvestFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _harvestRepository = HarvestRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onHarvestFetched(
    HarvestFetched event,
    Emitter<HarvestManagementState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == HarvestStatus.initial) {
        if (state.harvests.isNotEmpty) {
          state.harvests.clear();
        }
        final harvests = await _harvestRepository.fetchAllHarvestsByFarmer(
            i, _harvestLimit, farmerId);
        return emit(state.copyWith(
          status: HarvestStatus.success,
          harvests: harvests.items,
          hasReachedMax: harvests.total <= 10 ? true : false,
        ));
        // }
      }
      final harvests = await _harvestRepository.fetchAllHarvestsByFarmer(
          ++i, _harvestLimit, farmerId);
      harvests.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: HarvestStatus.success,
                harvests: List.of(state.harvests)..addAll(harvests.items),
                hasReachedMax: false,
              ),
            );
      // }
    } catch (_) {
      emit(state.copyWith(status: HarvestStatus.failure));
    }
  }
}
