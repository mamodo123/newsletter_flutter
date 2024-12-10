import 'package:newsletter/src/data/models/newsletter/newsletter.dart';

class NewsletterLocal extends NewsletterModel {
  final int synchronized;

  const NewsletterLocal(
      {required super.title,
      required super.category,
      required super.summary,
      required super.link,
      required super.createdAt,
      required this.synchronized});

  NewsletterLocal.fromJson({required super.json})
      : synchronized = json['synchronized'],
        super.fromJson();

  @override
  Map<String, dynamic> toJson() =>
      {...super.toJson(), 'synchronized': synchronized};
}
