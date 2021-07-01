import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedbacks/feedback_item.dart';

class FeedbacksRepository {
  final feedbackCollection = FirebaseFirestore.instance.collection('feedbacks');

  Stream<List<FeedbackItem>> feedbacks() {
    return feedbackCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => FeedbackItem.fromSnapshot(doc))
          .toList();
    });
  }

  Future<void> addNewFeedback(FeedbackItem feedback) {
    return feedbackCollection.add(feedback.toDocument);
  }

  Future<void> updateFeedback(FeedbackItem feedback) {
    return feedbackCollection.doc(feedback.id).update(feedback.toDocument);
  }

  Future<void> deleteFeedback(FeedbackItem feedback) async {
    return feedbackCollection.doc(feedback.id).delete();
  }
}
