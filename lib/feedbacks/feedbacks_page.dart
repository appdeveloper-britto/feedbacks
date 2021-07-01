import 'package:feedbacks/feedback_editor/feedback_editor.dart';
import 'package:feedbacks/feedback_item.dart';
import 'package:feedbacks/feedbacks/feedback_list_tile.dart';
import 'package:feedbacks/feedbacks/feedbacks_bloc.dart';
import 'package:feedbacks/feedbacks/feedbacks_event.dart';
import 'package:feedbacks/feedbacks/feedbacks_state.dart';
import 'package:feedbacks/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbacksPage extends StatelessWidget {
  FeedbacksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Feedbacks"),
      ),
      body: BlocBuilder<FeedbacksBloc, FeedbacksState>(
        builder: (context, state) {
          if (state is FeedbacksLoading) {
            return LoadingIndicator();
          } else if (state is FeedbacksLoaded) {
            final feedbacks = state.feedbacks;
            return ListView.builder(
              itemCount: feedbacks.length,
              itemBuilder: (context, index) {
                final feedback = feedbacks[index];
                return FeedbackListTitle(
                  feedback: feedback,
                  onLike: () {
                    int likeCount = feedback.likeCount + 1;
                    context.read<FeedbacksBloc>().add(
                          UpdateFeedback(
                            feedback.copyWith(likeCount: likeCount),
                          ),
                        );
                  },
                  onDislike: () {
                    int dislikeCount = feedback.dislikeCount + 1;
                    context.read<FeedbacksBloc>().add(
                          UpdateFeedback(
                            feedback.copyWith(dislikeCount: dislikeCount),
                          ),
                        );
                  },
                );
              },
            );
          } else if (state is FeedbacksLoaded) {
            return Container();
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          FeedbackItem? _feedback = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => FeedbackEditor()));
          if (_feedback != null) {
            context.read<FeedbacksBloc>().add(
                  AddFeedback(_feedback),
                );
          }
        },
      ),
    );
  }
}
