import 'package:newsletter/src/data/models/newsletter/newsletter.dart';

class NewsletterLocal extends NewsletterModel {
  final String? remote;

  const NewsletterLocal({
    required super.title,
    required super.category,
    required super.summary,
    required super.link,
    required super.createdAt,
    required super.uuid,
    required this.remote,
  });

  NewsletterLocal.fromJson({required Map<String, dynamic> json})
      : remote = json['remote'],
        super(
            title: json['title'],
            category: json['category'],
            summary: json['summary'],
            link: json['link'],
            createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
            uuid: json['uuid']);

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'remote': remote}
    ..['createdAt'] = createdAt.millisecondsSinceEpoch;
}
