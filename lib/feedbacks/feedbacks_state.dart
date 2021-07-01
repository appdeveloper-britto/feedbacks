import 'package:feedbacks/feedback_item.dart';

abstract class FeedbacksState {}

class FeedbacksLoading extends FeedbacksState {}

class FeedbacksLoaded extends FeedbacksState {
  final List<FeedbackItem> feedbacks;

  FeedbacksLoaded([this.feedbacks = const []]);
}

class FeedbacksNotLoaded extends FeedbacksState {}
