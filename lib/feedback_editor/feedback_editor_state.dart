import 'package:feedbacks/feedback_category.dart';
import 'package:feedbacks/feedback_editor/feedback_editor_form_state.dart';

class FeedbackEditorState {
  FeedbackEditorState({
    this.title = "",
    this.description = "",
    this.category = FeedbackCategory.none,
    this.anonymous = false,
    this.reporterName = "",
    this.state = FeedbackEditorFormState.initial,
  });

  final String title;
  final FeedbackCategory category;
  final String description;
  final bool anonymous;
  final String reporterName;
  final FeedbackEditorFormState state;

  FeedbackEditorState copyWith({
    String? title,
    FeedbackCategory? category,
    String? description,
    bool? anonymous,
    String? reporterName,
    FeedbackEditorFormState? state,
  }) {
    return FeedbackEditorState(
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      anonymous: anonymous ?? this.anonymous,
      reporterName: reporterName ?? this.reporterName,
      state: state ?? this.state,
    );
  }
}
