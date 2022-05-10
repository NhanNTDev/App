part of 'cancel_task_bloc.dart';

abstract class CancelTaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CancelFetched extends CancelTaskEvent {}
