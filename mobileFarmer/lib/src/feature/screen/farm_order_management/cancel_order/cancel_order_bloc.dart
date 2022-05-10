import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:farmer_application/src/feature/model/farm_order.dart';
import 'package:farmer_application/src/feature/repository/farm_order_repository.dart';
import 'package:farmer_application/src/feature/repository/farm_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'cancel_order_event.dart';

part 'cancel_order_state.dart';

const _farmOrderLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CancelFarmOrderBloc
    extends Bloc<CancelFarmOrderEvent, CancelFarmOrderState> {
  final String farmerId;

  CancelFarmOrderBloc({required this.httpClient, required this.farmerId})
      : super(const CancelFarmOrderState()) {
    on<CancelFarmOrderFetched>(
      _onCancelOrderFarmFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _needConfirmFarmOrderRepository = NeedConfirmFarmOrderRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onCancelOrderFarmFetched(
      CancelFarmOrderFetched event,
      Emitter<CancelFarmOrderState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == CancelFarmOrderStatus.initial) {
        if (state.farmOrders.isNotEmpty) {
          state.farmOrders.clear();
        }
        print(state.farmOrders.length);
        final farmOrders = await _needConfirmFarmOrderRepository
            .getListFarmOrder(i, _farmOrderLimit, farmerId, "7");
        return emit(state.copyWith(
          status: CancelFarmOrderStatus.success,
          farmOrders: farmOrders.items,
          hasReachedMax: farmOrders.total <= 10 ? true : false,
        ));
        // }
      }
      // print(2);
      final farmOrders = await _needConfirmFarmOrderRepository.getListFarmOrder(
          ++i, _farmOrderLimit, farmerId, "7");
      ;
      farmOrders.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: CancelFarmOrderStatus.success,
          farmOrders: List.of(state.farmOrders)..addAll(farmOrders.items),
          hasReachedMax: false,
        ),
      );
      // }
    } catch (_) {
      emit(state.copyWith(status: CancelFarmOrderStatus.failure));
    }
  }
}
