import 'dart:async';

import 'package:newsletter/src/data/models/newsletter/newsletter_remote.dart';

abstract class NewsletterServiceRemote {
  final StreamController<List<NewsletterRemote>> controller;

  NewsletterServiceRemote(this.controller);

  Stream<List<NewsletterRemote>> getNewsletterList();

  Future<void> addNewsletter(NewsletterRemote newsletter);
}
