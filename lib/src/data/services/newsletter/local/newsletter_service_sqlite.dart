import 'dart:async';

import 'package:newsletter/src/data/models/newsletter/newsletter_local.dart';
import 'package:rxdart/rxdart.dart';

import 'newsletter_service_local.dart';

class NewsletterServiceSqlite extends NewsletterServiceLocal {
  NewsletterServiceSqlite()
      : super(BehaviorSubject<List<NewsletterLocal>>.seeded([]));

  @override
  Future<void> addNewsletter(NewsletterLocal newsletter) {
    // TODO: implement addNewsletter
    throw UnimplementedError();
  }

  @override
  Stream<List<NewsletterLocal>> getNewsletterStream() {
    // TODO: implement getNewsletterStream
    throw UnimplementedError();
  }
}
