import 'package:feedbacks/feedback_category.dart';
import 'package:feedbacks/feedback_editor/feedback_editor_cubit.dart';
import 'package:feedbacks/feedback_editor/feedback_editor_form_state.dart';
import 'package:feedbacks/feedback_editor/feedback_editor_state.dart';
import 'package:feedbacks/feedback_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackEditor extends StatelessWidget {
  FeedbackEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add/Edit Feedback"),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return BlocProvider<FeedbackEditorCubit>(
      create: (_) => FeedbackEditorCubit(),
      child: BlocConsumer<FeedbackEditorCubit, FeedbackEditorState>(
        listener: (context, state) {
          if (state.state == FeedbackEditorFormState.submitting) {
            final feedback = FeedbackItem(
              id: "",
              title: state.title,
              category: state.category.intValue,
              description: state.description,
              reporterId: "",
              reporterName: state.reporterName,
              anonymous: state.anonymous,
              likeCount: 0,
              dislikeCount: 0,
            );
            Navigator.pop(context, feedback);
          }
        },
        builder: (cubit, state) => SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: _form(context),
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Column(
      children: [
        _FeedbackTitle(),
        SizedBox(height: 10),
        _CategoryDropDown(),
        SizedBox(height: 10),
        _DescriptionField(),
        SizedBox(height: 10),
        _AnonymousCheckbox(),
        SizedBox(height: 10),
        _ReporterName(),
        SizedBox(height: 50),
        _SubmitButton(),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackEditorCubit, FeedbackEditorState>(
      buildWhen: (previous, current) => previous.state != current.state,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            context.read<FeedbackEditorCubit>().submit();
          },
          child: Text("Submit"),
        );
      },
    );
  }
}

class _FeedbackTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackEditorCubit, FeedbackEditorState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return TextField(
          key: const Key("feedback_editor_title_textField"),
          onChanged: (value) =>
              context.read<FeedbackEditorCubit>().titleChanged(value),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "Title",
            helperText: "",
            errorText: state.title.isEmpty ? "Enter your feedback title" : null,
          ),
        );
      },
    );
  }
}

class _CategoryDropDown extends StatelessWidget {
  const _CategoryDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackEditorCubit, FeedbackEditorState>(
      buildWhen: (previous, current) => previous.category != current.category,
      builder: (context, state) {
        return DropdownButtonFormField<FeedbackCategory>(
          key: const Key("feedback_editor_category_dropdown"),
          value: state.category,
          isExpanded: true,
          decoration: InputDecoration(
            errorText:
                state.category.isEmpty ? "Enter your feedback category" : null,
          ),
          items: FeedbackCategory.values.map((category) {
            return DropdownMenuItem<FeedbackCategory>(
              value: category,
              child: category.isEmpty
                  ? Text(
                      category.stringValue ?? "Select",
                      style: TextStyle(color: Colors.grey[500]),
                      textAlign: TextAlign.center,
                    )
                  : Text(category.stringValue ?? ""),
            );
          }).toList(),
          onChanged: (value) =>
              context.read<FeedbackEditorCubit>().categoryChanged(value),
        );
      },
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackEditorCubit, FeedbackEditorState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextField(
          key: const Key("feedback_editor_description_textField"),
          onChanged: (value) =>
              context.read<FeedbackEditorCubit>().descriptionChanged(value),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "Description",
            alignLabelWithHint: true,
            helperText: "",
            errorText: state.description.isEmpty
                ? "Enter your feedback description"
                : null,
          ),
          maxLines: 4,
          minLines: 4,
        );
      },
    );
  }
}

class _AnonymousCheckbox extends StatelessWidget {
  const _AnonymousCheckbox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackEditorCubit, FeedbackEditorState>(
      buildWhen: (previous, current) => previous.anonymous != current.anonymous,
      builder: (context, state) {
        return CheckboxListTile(
          key: const Key("feedback_editor_anonymous_checkbox"),
          contentPadding: EdgeInsets.zero,
          title: Text("Anonymous"),
          value: state.anonymous,
          onChanged: (value) => context
              .read<FeedbackEditorCubit>()
              .anonymousChanged(value ?? false),
        );
      },
    );
  }
}

class _ReporterName extends StatelessWidget {
  const _ReporterName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackEditorCubit, FeedbackEditorState>(
      buildWhen: (previous, current) => previous.reporterName != current.title,
      builder: (context, state) {
        return !state.anonymous
            ? TextField(
                key: const Key("feedback_editor_reporter_name_textField"),
                onChanged: (value) => context
                    .read<FeedbackEditorCubit>()
                    .reporterNameChanged(value),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Reporter Name",
                  helperText: "",
                  errorText: (!state.anonymous && state.reporterName.isEmpty)
                      ? "Enter your feedback reporter name"
                      : null,
                ),
              )
            : Container();
      },
    );
  }
}
