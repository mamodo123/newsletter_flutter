import 'package:newsletter/src/data/models/newsletter/newsletter_local.dart';

abstract class NewsletterServiceLocal {
  Future<List<NewsletterLocal>> getNewsletterList();

  Future<void> addNewsletter(NewsletterLocal newsletter);
}
