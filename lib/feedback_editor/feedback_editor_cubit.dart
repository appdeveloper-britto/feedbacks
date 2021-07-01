import 'package:bloc/bloc.dart';
import 'package:feedbacks/feedback_category.dart';
import 'package:feedbacks/feedback_editor/feedback_editor_form_state.dart';
import 'package:feedbacks/feedback_editor/feedback_editor_state.dart';

class FeedbackEditorCubit extends Cubit<FeedbackEditorState> {
  FeedbackEditorCubit() : super(FeedbackEditorState());

  void titleChanged(String value) {
    emit(state.copyWith(
      title: value,
    ));
  }

  void categoryChanged(FeedbackCategory? value) {
    if (value != null) {
      emit(state.copyWith(
        category: value,
      ));
    }
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(
      description: value,
    ));
  }

  void anonymousChanged(bool value) {
    emit(state.copyWith(
      anonymous: value,
    ));
  }

  void reporterNameChanged(String value) {
    emit(state.copyWith(
      reporterName: value,
    ));
  }

  Future<void> submit() async {
    if (!validate) return;
    emit(state.copyWith(state: FeedbackEditorFormState.submitting));
  }

  bool get validate {
    if (state.title.isNotEmpty &&
        state.description.isNotEmpty &&
        (state.anonymous == true || state.reporterName.isNotEmpty)) return true;

    return false;
  }
}
