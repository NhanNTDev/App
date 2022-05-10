import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_driver_application/src/feature/model/collect_order.dart';
import 'package:delivery_driver_application/src/feature/repository/collect_order_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'cancel_task_event.dart';

part 'cancel_task_state.dart';

const _collectOrderLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CancelTaskBloc
    extends Bloc<CancelTaskEvent, CancelTaskState> {
  final String? search;
  final String farmerId;

  CancelTaskBloc({required this.httpClient, this.search, required this.farmerId})
      : super(const CancelTaskState()) {
    on<CancelFetched>(
      _onCancelTaskFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _collectOrderRepository = CollectOrderRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onCancelTaskFetched(
      CancelFetched event,
      Emitter<CancelTaskState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == CancelTaskStatus.initial) {
        if(state.collectOrders.isNotEmpty){
          state.collectOrders.clear();
        }
        // final collectOrders = await _collectOrderRepository.getListFarmOrder(i, _collectOrderLimit,farmerId, 7);
        final collectOrders = await _collectOrderRepository.getListFarmOrder(i, _collectOrderLimit,farmerId, true);
        return emit(state.copyWith(
          status: CancelTaskStatus.success,
          collectOrders: collectOrders.items,
          hasReachedMax: collectOrders.total <= 10 ? true : false,
        ));
      }
      // final collectOrders = await _collectOrderRepository.getListFarmOrder(++i, _collectOrderLimit,farmerId, 7);
      final collectOrders = await _collectOrderRepository.getListFarmOrder(++i, _collectOrderLimit,farmerId, true);
      collectOrders.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: CancelTaskStatus.success,
          collectOrders: List.of(state.collectOrders)..addAll(collectOrders.items),
          hasReachedMax: false,
        ),
      );
      // }
    } catch (_) {
      emit(state.copyWith(status: CancelTaskStatus.failure));
    }
  }
}
