part of 'wh_processing_task_bloc.dart';

abstract class WhProcessingTaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WhProcessingFetched extends WhProcessingTaskEvent {}
