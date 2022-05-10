import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:farmer_application/src/feature/model/farm_order.dart';
import 'package:farmer_application/src/feature/repository/farm_order_repository.dart';
import 'package:farmer_application/src/feature/repository/farm_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'processing_order_event.dart';

part 'processing_order_state.dart';

const _farmOrderLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProcessingFarmOrderBloc
    extends Bloc<ProcessingFarmOrderEvent, ProcessingFarmOrderState> {
  final String farmerId;

  ProcessingFarmOrderBloc({required this.httpClient, required this.farmerId})
      : super(const ProcessingFarmOrderState()) {
    on<ProcessingFarmOrderFetched>(
      _onProcessingOrderFarmFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _needConfirmFarmOrderRepository = NeedConfirmFarmOrderRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onProcessingOrderFarmFetched(
      ProcessingFarmOrderFetched event,
      Emitter<ProcessingFarmOrderState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ProcessingFarmOrderStatus.initial) {
        if (state.farmOrders.isNotEmpty) {
          state.farmOrders.clear();
        }
        print(state.farmOrders.length);
        final farmOrders = await _needConfirmFarmOrderRepository
            .getListFarmOrder(i, _farmOrderLimit, farmerId, "2");
        return emit(state.copyWith(
          status: ProcessingFarmOrderStatus.success,
          farmOrders: farmOrders.items,
          hasReachedMax: farmOrders.total <= 10 ? true : false,
        ));
        // }
      }
      // print(2);
      final farmOrders = await _needConfirmFarmOrderRepository.getListFarmOrder(
          ++i, _farmOrderLimit, farmerId, "2");
      ;
      farmOrders.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: ProcessingFarmOrderStatus.success,
          farmOrders: List.of(state.farmOrders)..addAll(farmOrders.items),
          hasReachedMax: false,
        ),
      );
      // }
    } catch (_) {
      emit(state.copyWith(status: ProcessingFarmOrderStatus.failure));
    }
  }
}
