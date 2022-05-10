import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_driver_application/src/feature/model/collect_order.dart';
import 'package:delivery_driver_application/src/feature/repository/collect_order_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'processing_task_event.dart';

part 'processing_task_state.dart';

const _collectOrderLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProcessingTaskBloc
    extends Bloc<ProcessingTaskEvent, ProcessingTaskState> {
  final String? search;
  final String farmerId;

  ProcessingTaskBloc({required this.httpClient, this.search, required this.farmerId})
      : super(const ProcessingTaskState()) {
    on<ProcessingFetched>(
      _onProcessingTaskFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _collectOrderRepository = CollectOrderRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onProcessingTaskFetched(
      ProcessingFetched event,
      Emitter<ProcessingTaskState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ProcessingTaskStatus.initial) {
        if(state.collectOrders.isNotEmpty){
          state.collectOrders.clear();
        }
        final collectOrders = await _collectOrderRepository.getListFarmOrder(i, _collectOrderLimit,farmerId, false);
        return emit(state.copyWith(
          status: ProcessingTaskStatus.success,
          collectOrders: collectOrders.items,
          hasReachedMax: collectOrders.items.length <= 10 ? true : false,
        ));
      }
      final collectOrders = await _collectOrderRepository.getListFarmOrder(++i, _collectOrderLimit,farmerId, false);
      collectOrders.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: ProcessingTaskStatus.success,
          collectOrders: List.of(state.collectOrders)..addAll(collectOrders.items),
          hasReachedMax: false,
        ),
      );
      // }
    } catch (_) {
      emit(state.copyWith(status: ProcessingTaskStatus.failure));
    }
  }
}
