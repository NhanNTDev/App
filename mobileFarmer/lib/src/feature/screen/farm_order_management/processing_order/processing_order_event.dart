part of 'processing_order_bloc.dart';

abstract class ProcessingFarmOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProcessingFarmOrderFetched extends ProcessingFarmOrderEvent {}
