import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_driver_application/src/feature/model/shipping_order.dart';
import 'package:delivery_driver_application/src/feature/repository/shipping_order_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'shipping_processing_task_event.dart';

part 'shipping_processing_task_state.dart';

const _shippingOrderLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ShippingProcessingTaskBloc
    extends Bloc<ShippingProcessingTaskEvent, ShippingProcessingTaskState> {
  final String driverId;

  ShippingProcessingTaskBloc({required this.httpClient, required this.driverId})
      : super(const ShippingProcessingTaskState()) {
    on<ShippingProcessingFetched>(
      _onShippingProcessingTaskFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _shippingOrderRepository = ShippingOrderRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onShippingProcessingTaskFetched(
      ShippingProcessingFetched event,
      Emitter<ShippingProcessingTaskState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ShippingProcessingTaskStatus.initial) {
        if(state.shippingOrders.isNotEmpty){
          state.shippingOrders.clear();
        }
        final shippingOrders = await _shippingOrderRepository.getListShippingOrders(i, _shippingOrderLimit,driverId, false);
        return emit(state.copyWith(
          status: ShippingProcessingTaskStatus.success,
          shippingOrders: shippingOrders.items,
          hasReachedMax: shippingOrders.total <= 10 ? true : false,
        ));
      }
      final shippingOrders = await _shippingOrderRepository.getListShippingOrders(++i, _shippingOrderLimit,driverId, false);
      shippingOrders.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: ShippingProcessingTaskStatus.success,
          shippingOrders: List.of(state.shippingOrders)..addAll(shippingOrders.items),
          hasReachedMax: false,
        ),
      );
      // }
    } catch (_) {
      emit(state.copyWith(status: ShippingProcessingTaskStatus.failure));
    }
  }
}
