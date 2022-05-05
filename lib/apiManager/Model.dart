class FetchLearnerDetailsList {
  final String id;
  final String title;
  final String description;
  final String video;
  final String image;
  FetchLearnerDetailsList(
      {required this.id,
      required this.title,
      required this.description,
      required this.video,
      required this.image});
}

class UserProgressList {
  final String id;
  final String year;
  final String rate;

  UserProgressList({required this.id, required this.year, required this.rate});
}

class CategoryList {
  final String tutoriral_id;
  final String tutoriral_name;
  final String tutorialVideo;

  CategoryList(
      {required this.tutoriral_id,
      required this.tutoriral_name,
      required this.tutorialVideo});
}

class TutorialDetailsList {
  final String id;
  final String title;
  final String description;
  final String video;
  final String tutorail_image;

  TutorialDetailsList(
      {required this.id,
      required this.title,
      required this.description,
      required this.video,
      required this.tutorail_image});
}

class NotificationList {
  final String user_id;
  final String user_name;
  final String message;
  final String image;

  NotificationList(
      {required this.user_id,
      required this.user_name,
      required this.message,
      required this.image});
}

class FetchTestList {
  final String testid;
  final String testType;
  final String tname;
  final String description;
  final String video;
  final String test_image;

  FetchTestList(
      {required this.testid,
      required this.testType,
      required this.tname,
      required this.description,
      required this.video,
      required this.test_image,
      });
}