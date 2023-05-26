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
      title: 'One app for all your payments and business needs',
      // image: 'images/quality.svg',
      discription:
          "Access all business payment solutions like contactless pos, scheduled payments, transfers"),
  UnbordingContent(
      title: 'Banking that sorts your lifestyle',
      // image: 'images/delevery.svg',
      discription:
          "We comply with all guideline by regulators to protect your funds imagine icon that depicts safety"),
  UnbordingContent(
      title: 'Secured Service',
      // image: 'images/delevery.svg',
      discription:
          "We comply with all guideline by regulators to protect your funds imagine icon that depicts safety"),
  UnbordingContent(
      title: 'Here  for business',
      // image: 'images/reward.svg',
      discription:
          "Access all business payment solutions like contactless pos, scheduled payments, transfers"),
];
