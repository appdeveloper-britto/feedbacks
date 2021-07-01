import 'package:feedbacks/feedback_item.dart';
import 'package:flutter/material.dart';

class FeedbackListTitle extends StatelessWidget {
  const FeedbackListTitle({
    Key? key,
    required this.feedback,
    required this.onLike,
    required this.onDislike,
  }) : super(key: key);

  final FeedbackItem feedback;
  final Function() onLike;
  final Function() onDislike;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  feedback.title,
                  style: textTheme.headline6,
                )),
                Text(
                  feedback.anonymous ? "Anonymous" : feedback.reporterName,
                  style: textTheme.bodyText1,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              feedback.description,
              style: textTheme.bodyText2,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "${feedback.dislikeCount} Dislikes",
                  style: TextStyle(
                    fontSize: textTheme.bodyText2?.fontSize ?? 10,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${feedback.likeCount} Likes",
                  style: TextStyle(
                    fontSize: textTheme.bodyText2?.fontSize ?? 10,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: IconButton(
                    onPressed: onDislike,
                    icon: Icon(
                      Icons.thumb_down,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: IconButton(
                    onPressed: onLike,
                    icon: Icon(
                      Icons.thumb_up,
                      color: Colors.green,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
