enum FeedbackCategory {
  none,
  network,
  feedback,
  input,
  hardware,
  interTeam,
  collaboration,
  other,
}

extension FeedbackCategoryValue on FeedbackCategory {
  bool get isEmpty => this == FeedbackCategory.none;

  String? get stringValue {
    switch (this) {
      case FeedbackCategory.none:
        return "Select";
      case FeedbackCategory.network:
        return "Network";
      case FeedbackCategory.feedback:
        return "Feedback";
      case FeedbackCategory.input:
        return "Input";
      case FeedbackCategory.hardware:
        return "Hardware";
      case FeedbackCategory.interTeam:
        return "Inter-Team";
      case FeedbackCategory.collaboration:
        return "Collaboration";
      case FeedbackCategory.other:
        return "Other";
      default:
        return null;
    }
  }

  int get intValue {
    switch (this) {
      case FeedbackCategory.network:
        return 1;
      case FeedbackCategory.feedback:
        return 2;
      case FeedbackCategory.input:
        return 3;
      case FeedbackCategory.hardware:
        return 4;
      case FeedbackCategory.interTeam:
        return 5;
      case FeedbackCategory.collaboration:
        return 6;
      case FeedbackCategory.other:
        return 7;
      case FeedbackCategory.none:
      default:
        return 0;
    }
  }
}

/*
Network, Feedback, Input, Hardware, Inter-Team, Collaboration,Other
 */