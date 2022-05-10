import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:farmer_application/src/feature/model/farm_order.dart';
import 'package:farmer_application/src/feature/repository/farm_order_repository.dart';
import 'package:farmer_application/src/feature/repository/farm_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'need_confirm_order_event.dart';

part 'need_confirm_order_state.dart';

const _farmOrderLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class NeedConfirmFarmOrderBloc
    extends Bloc<NeedConfirmFarmOrderEvent, NeedConfirmFarmOrderState> {
  final String farmerId;

  NeedConfirmFarmOrderBloc({required this.httpClient, required this.farmerId})
      : super(const NeedConfirmFarmOrderState()) {
    on<NeedConfirmFarmOrderFetched>(
      _onNeedConfirmOrderFarmFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _needConfirmFarmOrderRepository = NeedConfirmFarmOrderRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onNeedConfirmOrderFarmFetched(
    NeedConfirmFarmOrderFetched event,
    Emitter<NeedConfirmFarmOrderState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == NeedConfirmFarmOrderStatus.initial) {
        if (state.farmOrders.isNotEmpty) {
          state.farmOrders.clear();
        }
        print(state.farmOrders.length);
        final farmOrders = await _needConfirmFarmOrderRepository
            .getListFarmOrder(i, _farmOrderLimit, farmerId, "0");
        return emit(state.copyWith(
          status: NeedConfirmFarmOrderStatus.success,
          farmOrders: farmOrders.items,
          hasReachedMax: farmOrders.total <= 10 ? true : false,
        ));
        // }
      }
      // print(2);
      final farmOrders = await _needConfirmFarmOrderRepository.getListFarmOrder(
          ++i, _farmOrderLimit, farmerId, "0");
      ;
      farmOrders.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: NeedConfirmFarmOrderStatus.success,
                farmOrders: List.of(state.farmOrders)..addAll(farmOrders.items),
                hasReachedMax: false,
              ),
            );
      // }
    } catch (_) {
      emit(state.copyWith(status: NeedConfirmFarmOrderStatus.failure));
    }
  }
}
