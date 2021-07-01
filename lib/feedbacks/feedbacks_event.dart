import 'package:feedbacks/feedback_item.dart';

abstract class FeedbacksEvent {
  const FeedbacksEvent();
}

class LoadFeedbacks extends FeedbacksEvent {}

class LoadFeedbackCategories extends FeedbacksEvent {}

class AddFeedback extends FeedbacksEvent {
  final FeedbackItem feedback;

  const AddFeedback(this.feedback);
}

class UpdateFeedback extends FeedbacksEvent {
  final FeedbackItem updatedFeedback;

  const UpdateFeedback(this.updatedFeedback);
}

class DeleteFeedback extends FeedbacksEvent {
  final FeedbackItem feedback;

  const DeleteFeedback(this.feedback);
}

class FeedbacksUpdated extends FeedbacksEvent {
  final List<FeedbackItem> feedbacks;

  const FeedbacksUpdated(this.feedbacks);
}
