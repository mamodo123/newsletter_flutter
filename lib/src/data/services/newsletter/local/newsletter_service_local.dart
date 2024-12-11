import 'dart:async';

import 'package:newsletter/src/data/models/newsletter/newsletter_local.dart';
import 'package:rxdart/rxdart.dart';

abstract class NewsletterServiceLocal {
  final BehaviorSubject<List<NewsletterLocal>> subject;

  NewsletterServiceLocal(this.subject);

  Stream<List<NewsletterLocal>> getNewsletterStream();

  Future<void> addNewsletter(NewsletterLocal newsletter);
}
