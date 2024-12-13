class NewsletterModel {
  final String title, category, summary, link, uuid;
  final DateTime createdAt;

  const NewsletterModel(
      {required this.title,
      required this.category,
      required this.summary,
      required this.link,
      required this.createdAt,
      required this.uuid});

  NewsletterModel.fromJson({required Map<String, dynamic> json})
      : title = json['title'],
        category = json['category'],
        summary = json['summary'],
        link = json['link'],
        createdAt = json['createdAt'],
        uuid = json['uuid'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'category': category,
        'summary': summary,
        'link': link,
        'createdAt': createdAt,
        'uuid': uuid
      };
}
