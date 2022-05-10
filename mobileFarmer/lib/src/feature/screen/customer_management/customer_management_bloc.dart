import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:farmer_application/src/feature/repository/customer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import '../../model/customer.dart';

part 'customer_management_event.dart';
part 'customer_management_state.dart';

const _customerLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CustomerManagementBloc
    extends Bloc<CustomerManagementEvent, CustomerManagementState> {
  final String farmerId;

  CustomerManagementBloc({required this.httpClient, required this.farmerId})
      : super(const CustomerManagementState()) {
    on<CustomerFetched>(
      _onCustomerFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _customerRepository = CustomerRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onCustomerFetched(
      CustomerFetched event,
      Emitter<CustomerManagementState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == CustomerStatus.initial) {
        if(state.customers.isNotEmpty){
          state.customers.clear();
        }
        final customers = await _customerRepository.getListCustomer(i, _customerLimit, farmerId);
        return emit(state.copyWith(
          status: CustomerStatus.success,
          customers: customers.items,
          hasReachedMax: customers.total <= 10 ? true : false,
        ));
      }
      final customers = await _customerRepository.getListCustomer(++i, _customerLimit, farmerId);
      customers.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: CustomerStatus.success,
          customers: List.of(state.customers)..addAll(customers.items),
          hasReachedMax: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CustomerStatus.failure));
    }
  }
}
