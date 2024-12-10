import 'package:newsletter/src/data/models/newsletter/newsletter.dart';

class NewsletterRemote extends NewsletterModel {
  NewsletterRemote(
      {required super.title,
      required super.category,
      required super.summary,
      required super.link,
      required super.createdAt});

  NewsletterRemote.fromJson({required super.json}) : super.fromJson();

  // @override
// Map<String, dynamic> toJson() => super.toJson();
}
