import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_driver_application/src/feature/model/shipping_order.dart';
import 'package:delivery_driver_application/src/feature/repository/shipping_order_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'shipping_cancel_task_event.dart';

part 'shipping_cancel_task_state.dart';

const _shippingOrderLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ShippingCancelTaskBloc
    extends Bloc<ShippingCancelTaskEvent, ShippingCancelTaskState> {
  final String driverId;

  ShippingCancelTaskBloc({required this.httpClient, required this.driverId})
      : super(const ShippingCancelTaskState()) {
    on<ShippingCancelFetched>(
      _onShippingCancelTaskFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _shippingOrderRepository = ShippingOrderRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onShippingCancelTaskFetched(
    ShippingCancelFetched event,
    Emitter<ShippingCancelTaskState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ShippingCancelTaskStatus.initial) {
        if (state.shippingOrders.isNotEmpty) {
          state.shippingOrders.clear();
        }
        final shippingOrders = await _shippingOrderRepository.getListShippingOrders(
            i, _shippingOrderLimit, driverId, true);
        return emit(state.copyWith(
          status: ShippingCancelTaskStatus.success,
          shippingOrders: shippingOrders.items,
          hasReachedMax: shippingOrders.total <= 10 ? true : false,
        ));
      }
      final shippingOrders = await _shippingOrderRepository.getListShippingOrders(
          ++i, _shippingOrderLimit, driverId, true);
      shippingOrders.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: ShippingCancelTaskStatus.success,
                shippingOrders: List.of(state.shippingOrders)
                  ..addAll(shippingOrders.items),
                hasReachedMax: false,
              ),
            );
      // }
    } catch (_) {
      emit(state.copyWith(status: ShippingCancelTaskStatus.failure));
    }
  }
}
