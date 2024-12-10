class Newsletter {
  final String title, category, summary, link;
  final DateTime createdAt;

  Newsletter(
      {required this.title,
      required this.category,
      required this.summary,
      required this.link,
      required this.createdAt});
}
