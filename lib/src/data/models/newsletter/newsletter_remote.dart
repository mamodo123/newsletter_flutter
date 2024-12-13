import 'package:newsletter/src/data/models/newsletter/newsletter.dart';

class NewsletterRemote extends NewsletterModel {
  final String? remoteId;

  NewsletterRemote(
      {required super.title,
      required super.category,
      required super.summary,
      required super.link,
      required super.createdAt,
      required super.uuid,
      required this.remoteId});

  NewsletterRemote.fromJson(
      {required Map<String, dynamic> json, required this.remoteId})
      : super(
          title: json['title'],
          category: json['category'],
          summary: json['summary'],
          link: json['link'],
          createdAt: json['createdAt'].toDate(),
          uuid: json['uuid'],
        );

// @override
// Map<String, dynamic> toJson() => super.toJson();
}
