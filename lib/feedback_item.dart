import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackItem {
  final String id;
  final String title;
  final int category;
  final String description;
  final String reporterId;
  final String reporterName;
  final bool anonymous;
  final int likeCount;
  final int dislikeCount;

  const FeedbackItem({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.reporterId,
    required this.reporterName,
    required this.anonymous,
    required this.likeCount,
    required this.dislikeCount,
  });

  FeedbackItem copyWith({
    String? id,
    String? title,
    int? category,
    String? description,
    String? reporterId,
    String? reporterName,
    bool? anonymous,
    int? likeCount,
    int? dislikeCount,
  }) {
    return FeedbackItem(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      reporterId: reporterId ?? this.reporterId,
      reporterName: reporterName ?? this.reporterName,
      anonymous: anonymous ?? this.anonymous,
      likeCount: likeCount ?? this.likeCount,
      dislikeCount: dislikeCount ?? this.dislikeCount,
    );
  }

  static FeedbackItem fromSnapshot(DocumentSnapshot snap) {
    final Map<String, dynamic>? data = snap.data() as Map<String, dynamic>;
    if (data == null) throw Exception();
    return FeedbackItem(
      id: snap.id,
      title: data["title"],
      category: data["category"],
      description: data["description"],
      reporterId: data["reporter_id"],
      reporterName: data["reporter_name"],
      anonymous: data["anonymous"],
      likeCount: data["like_count"],
      dislikeCount: data["dislike_count"],
    );
  }

  Map<String, dynamic> get toDocument {
    return {
      'title': title,
      'category': category,
      'description': description,
      'reporter_id': reporterId,
      'reporter_name': reporterName,
      'anonymous': anonymous,
      'like_count': likeCount,
      'dislike_count': dislikeCount,
    };
  }
}
