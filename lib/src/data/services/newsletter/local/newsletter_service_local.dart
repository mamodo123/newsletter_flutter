import 'dart:async';

import 'package:newsletter/src/data/models/newsletter/newsletter_local.dart';

abstract class NewsletterServiceLocal {
  NewsletterServiceLocal();

  Stream<List<NewsletterLocal>> getNewsletterStream();

  Future<void> addNewsletter(NewsletterLocal newsletter);
}
