import 'dart:async';

import 'package:newsletter/src/data/models/newsletter/newsletter_remote.dart';
import 'package:rxdart/rxdart.dart';

abstract class NewsletterServiceRemote {

  final BehaviorSubject<List<NewsletterRemote>> subject;

  NewsletterServiceRemote(this.subject);

  Stream<List<NewsletterRemote>> getNewsletterStream();

  Future<void> addNewsletter(NewsletterRemote newsletter);

  void dispose() {
    subject.close();
  }
}
