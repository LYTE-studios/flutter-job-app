class ListData {
  final String image;
  final String title;
  final String subTitle;
  final String duration;
  final String? time;

  ListData({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.duration,
    this.time,
  });
}
