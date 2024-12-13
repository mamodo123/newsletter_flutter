import 'dart:async';

import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/models/newsletter/newsletter_remote.dart';
import 'package:rxdart/rxdart.dart';

abstract class NewsletterServiceRemote {
  final BehaviorSubject<List<NewsletterRemote>> subject;

  NewsletterServiceRemote(this.subject);

  Stream<List<NewsletterRemote>> getNewsletterStream();

  Future<Result<String>> addNewsletter(NewsletterRemote newsletter);

  Future<Result<void>> connect();

  Future<Result<void>> disconnect();

  void dispose() {
    subject.close();
  }
}
