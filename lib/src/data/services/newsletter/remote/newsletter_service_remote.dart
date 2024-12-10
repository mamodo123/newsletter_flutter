import 'package:newsletter/src/data/models/newsletter/newsletter_remote.dart';

abstract class NewsletterServiceRemote {
  Future<List<NewsletterRemote>> getNewsletterList();

  Future<void> addNewsletter(NewsletterRemote newsletter);
}
