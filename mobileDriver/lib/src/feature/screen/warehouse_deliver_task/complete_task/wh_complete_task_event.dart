part of 'wh_complete_task_bloc.dart';

abstract class WhCompleteTaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WhCompleteFetched extends WhCompleteTaskEvent {}
