part of 'customer_management_bloc.dart';

enum CustomerStatus { initial, success, failure }

class CustomerManagementState extends Equatable {
  const CustomerManagementState({
    this.status = CustomerStatus.initial,
    this.customers = const <Customer>[],
    this.hasReachedMax = false,
  });

  final CustomerStatus status;
  final List<Customer> customers;
  final bool hasReachedMax;

  CustomerManagementState copyWith({
    CustomerStatus? status,
    List<Customer>? customers,
    bool? hasReachedMax,
  }) {
    return CustomerManagementState(
      status: status ?? this.status,
      customers: customers ?? this.customers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''CustomerManagementState { status: $status, hasReachedMax: $hasReachedMax, farms: ${customers.length} }''';
  }

  @override
  List<Object> get props => [status, customers, hasReachedMax];
}
