import 'package:sprout_mobile/config/Config.dart';

class UnbordingContent {
  //String? image;
  String title;
  String discription;

  UnbordingContent({
    // this.image,
    required this.title,
    required this.discription,
  });
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: APP_ONBOARDING_TITLE_1, discription: APP_ONBOARDING_DESCRIPTION_1),
  UnbordingContent(
      title: APP_ONBOARDING_TITLE_2, discription: APP_ONBOARDING_DESCRIPTION_2),
  UnbordingContent(
      title: APP_ONBOARDING_TITLE_3, discription: APP_ONBOARDING_DESCRIPTION_3),
  UnbordingContent(
      title: APP_ONBOARDING_TITLE_4, discription: APP_ONBOARDING_DESCRIPTION_4),
];
