import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:farmer_application/src/feature/model/farm.dart';
import 'package:farmer_application/src/feature/repository/farm_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'farm_management_event.dart';

part 'farm_management_state.dart';

const _farmLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class FarmManagementBloc
    extends Bloc<FarmManagementEvent, FarmManagementState> {
  final String? search;
  final String farmerId;

  FarmManagementBloc(
      {required this.httpClient, this.search, required this.farmerId})
      : super(const FarmManagementState()) {
    on<FarmFetched>(
      _onFarmFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _farmRepository = FarmRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onFarmFetched(
    FarmFetched event,
    Emitter<FarmManagementState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == FarmStatus.initial) {
        if (state.farms.isNotEmpty) {
          state.farms.clear();
        }
        final farms =
            await _farmRepository.fetchAllFarmByFarmer(i, _farmLimit, farmerId);
        return emit(state.copyWith(
          status: FarmStatus.success,
          farms: farms.items,
          hasReachedMax: farms.total <= 10 ? true : false,
        ));
      }
      final farms =
          await _farmRepository.fetchAllFarmByFarmer(++i, _farmLimit, farmerId);
      farms.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: FarmStatus.success,
                farms: List.of(state.farms)..addAll(farms.items),
                hasReachedMax: false,
              ),
            );
      // }
    } catch (_) {
      emit(state.copyWith(status: FarmStatus.failure));
    }
  }
}
