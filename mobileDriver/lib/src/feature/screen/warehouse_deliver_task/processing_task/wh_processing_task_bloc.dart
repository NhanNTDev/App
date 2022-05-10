import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_driver_application/src/feature/model/collect_order.dart';
import 'package:delivery_driver_application/src/feature/model/warehouse_deliver_order.dart';
import 'package:delivery_driver_application/src/feature/repository/collect_order_repository.dart';
import 'package:delivery_driver_application/src/feature/repository/warehouse_deliver_order_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'wh_processing_task_event.dart';

part 'wh_processing_task_state.dart';

const _warehouseDeliverOrderLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class WhProcessingTaskBloc
    extends Bloc<WhProcessingTaskEvent, WhProcessingTaskState> {
  final String? search;
  final String driverId;

  WhProcessingTaskBloc({required this.httpClient, this.search, required this.driverId})
      : super(const WhProcessingTaskState()) {
    on<WhProcessingFetched>(
      _onWhProcessingTaskFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _warehouseDeliverOrderRepository = WarehouseDeliverOrderRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onWhProcessingTaskFetched(
      WhProcessingFetched event,
      Emitter<WhProcessingTaskState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == WhProcessingTaskStatus.initial) {
        if(state.warehouseDeliverOrders.isNotEmpty){
          state.warehouseDeliverOrders.clear();
        }
        final warehouseDeliverOrders = await _warehouseDeliverOrderRepository.getListShipment(i, _warehouseDeliverOrderLimit,driverId, 0);
        return emit(state.copyWith(
          status: WhProcessingTaskStatus.success,
          warehouseDeliverOrders: warehouseDeliverOrders.items,
          hasReachedMax: warehouseDeliverOrders.total <= 10 ? true : false,
        ));
      }
      final warehouseDeliverOrders = await _warehouseDeliverOrderRepository.getListShipment(++i, _warehouseDeliverOrderLimit,driverId, 0);
      warehouseDeliverOrders.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: WhProcessingTaskStatus.success,
          warehouseDeliverOrders: List.of(state.warehouseDeliverOrders)..addAll(warehouseDeliverOrders.items),
          hasReachedMax: false,
        ),
      );
      // }
    } catch (_) {
      emit(state.copyWith(status: WhProcessingTaskStatus.failure));
    }
  }
}
