import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:farmer_application/src/feature/model/feedback.dart';
import 'package:farmer_application/src/feature/repository/farm_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'feedback_in_farm_event.dart';
part 'feedback_in_farm_state.dart';

const _feedbackLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class FeedbackInFarmBloc
    extends Bloc<FeedbackInFarmEvent, FeedbackInFarmState> {
  final int farmId;

  FeedbackInFarmBloc({required this.httpClient, required this.farmId})
      : super(const FeedbackInFarmState()) {
    on<FeedbackInFarmFetched>(
      _onFeedbackInFarmFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final _farmRepository = FarmRepository();
  int i = 1;

  final http.Client httpClient;

  Future<void> _onFeedbackInFarmFetched(
    FeedbackInFarmFetched event,
    Emitter<FeedbackInFarmState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == FeedbackInFarmStatus.initial) {
        if (state.feedbacks.isNotEmpty) {
          state.feedbacks.clear();
        }
        final feedbacks = await _farmRepository.getListFeedBackByFarm(i, _feedbackLimit, farmId);
        return emit(state.copyWith(
          status: FeedbackInFarmStatus.success,
          feedbacks: feedbacks.items,
          hasReachedMax: feedbacks.total <= 10 ? true : false,
        ));
      }
      final feedbacks = await _farmRepository.getListFeedBackByFarm(++i, _feedbackLimit, farmId);
      feedbacks.items.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: FeedbackInFarmStatus.success,
                feedbacks: List.of(state.feedbacks)..addAll(feedbacks.items),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: FeedbackInFarmStatus.failure));
    }
  }
}
