part of 'processing_task_bloc.dart';

abstract class ProcessingTaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProcessingFetched extends ProcessingTaskEvent {}
