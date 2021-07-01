import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:feedbacks/feedbacks/feedbacks_event.dart';
import 'package:feedbacks/feedbacks/feedbacks_repository.dart';
import 'package:feedbacks/feedbacks/feedbacks_state.dart';

class FeedbacksBloc extends Bloc<FeedbacksEvent, FeedbacksState> {
  final FeedbacksRepository _feedbacksRepository;
  StreamSubscription? _feedbacksSubscription;

  FeedbacksBloc({required FeedbacksRepository feedbacksRepository})
      : _feedbacksRepository = feedbacksRepository,
        super(FeedbacksLoading());

  @override
  Stream<FeedbacksState> mapEventToState(FeedbacksEvent event) async* {
    if (event is LoadFeedbacks) {
      yield* _mapLoadFeedbacksToState();
    } else if (event is AddFeedback) {
      yield* _mapAddFeedbackToState(event);
    } else if (event is UpdateFeedback) {
      yield* _mapUpdateFeedbackToState(event);
    } else if (event is DeleteFeedback) {
      yield* _mapDeleteFeedbackToState(event);
    } else if (event is FeedbacksUpdated) {
      yield* _mapFeedbacksUpdateToState(event);
    }
  }

  Stream<FeedbacksState> _mapLoadFeedbacksToState() async* {
    _feedbacksSubscription?.cancel();
    _feedbacksSubscription = _feedbacksRepository.feedbacks().listen(
          (feedbacks) => add(FeedbacksUpdated(feedbacks)),
        );
  }

  Stream<FeedbacksState> _mapAddFeedbackToState(AddFeedback event) async* {
    _feedbacksRepository.addNewFeedback(event.feedback);
  }

  Stream<FeedbacksState> _mapUpdateFeedbackToState(
      UpdateFeedback event) async* {
    _feedbacksRepository.updateFeedback(event.updatedFeedback);
  }

  Stream<FeedbacksState> _mapDeleteFeedbackToState(
      DeleteFeedback event) async* {
    _feedbacksRepository.deleteFeedback(event.feedback);
  }

  Stream<FeedbacksState> _mapFeedbacksUpdateToState(
      FeedbacksUpdated event) async* {
    yield FeedbacksLoaded(event.feedbacks);
  }

  @override
  Future<void> close() {
    _feedbacksSubscription?.cancel();
    return super.close();
  }
}
