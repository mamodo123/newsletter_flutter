import 'package:newsletter/src/data/models/newsletter/newsletter.dart';

class NewsletterLocal extends NewsletterModel {
  final int? id;
  final String? remote;

  const NewsletterLocal(
      {required super.title,
      required super.category,
      required super.summary,
      required super.link,
      required super.createdAt,
      required this.remote,
      this.id});

  NewsletterLocal.fromJson({required Map<String, dynamic> json})
      : remote = json['remote'],
        id = json['id'],
        super(
          title: json['title'],
          category: json['category'],
          summary: json['summary'],
          link: json['link'],
          createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        );

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'remote': remote}
    ..['createdAt'] = createdAt.millisecondsSinceEpoch;
}
