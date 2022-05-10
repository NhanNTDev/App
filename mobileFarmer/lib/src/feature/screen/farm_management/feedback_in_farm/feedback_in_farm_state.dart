part of 'feedback_in_farm_bloc.dart';

enum FeedbackInFarmStatus { initial, success, failure }

class FeedbackInFarmState extends Equatable {
  const FeedbackInFarmState({
    this.status = FeedbackInFarmStatus.initial,
    this.feedbacks = const <FeedbackInFarm>[],
    this.hasReachedMax = false,
  });

  final FeedbackInFarmStatus status;
  final List<FeedbackInFarm> feedbacks;
  final bool hasReachedMax;

  FeedbackInFarmState copyWith({
    FeedbackInFarmStatus? status,
    List<FeedbackInFarm>? feedbacks,
    bool? hasReachedMax,
  }) {
    return FeedbackInFarmState(
      status: status ?? this.status,
      feedbacks: feedbacks ?? this.feedbacks,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''FeedbackInFarmState { status: $status, hasReachedMax: $hasReachedMax, farms: ${feedbacks.length} }''';
  }

  @override
  List<Object> get props => [status, feedbacks, hasReachedMax];
}
