part of 'customer_management_bloc.dart';

abstract class CustomerManagementEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CustomerFetched extends CustomerManagementEvent {}
