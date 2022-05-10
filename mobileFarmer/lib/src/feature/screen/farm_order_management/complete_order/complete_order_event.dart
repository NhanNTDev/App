part of 'complete_order_bloc.dart';

abstract class CompleteFarmOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CompleteFarmOrderFetched extends CompleteFarmOrderEvent {}
