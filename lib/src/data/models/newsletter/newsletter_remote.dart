import 'package:newsletter/src/data/models/newsletter/newsletter.dart';

class NewsletterRemote extends NewsletterModel {
  NewsletterRemote(
      {required super.title,
      required super.category,
      required super.summary,
      required super.link,
      required super.createdAt});

  NewsletterRemote.fromJson({required Map<String, dynamic> json})
      : super(
          title: json['title'],
          category: json['category'],
          summary: json['summary'],
          link: json['link'],
          createdAt: json['createdAt'].toDate(),
        );

// @override
// Map<String, dynamic> toJson() => super.toJson();
}
