part of 'complete_task_bloc.dart';

abstract class CompleteTaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CompleteFetched extends CompleteTaskEvent {}
