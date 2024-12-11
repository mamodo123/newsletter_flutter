import 'dart:async';

import 'package:newsletter/src/data/models/newsletter/newsletter_remote.dart';

abstract class NewsletterServiceRemote {

  Stream<List<NewsletterRemote>> getNewsletterStream();

  Future<void> addNewsletter(NewsletterRemote newsletter);
}
