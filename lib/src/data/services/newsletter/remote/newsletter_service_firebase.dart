import 'dart:async';

import 'package:newsletter/src/data/models/newsletter/newsletter_remote.dart';

import 'newsletter_service_remote.dart';

class NewsletterServiceFirebase extends NewsletterServiceRemote {
  NewsletterServiceFirebase()
      : super(StreamController<List<NewsletterRemote>>.broadcast());

  @override
  Future<void> addNewsletter(NewsletterRemote newsletter) {
    // TODO: implement addNewsletter
    throw UnimplementedError();
  }

  @override
  Stream<List<NewsletterRemote>> getNewsletterList() {
    // TODO: implement getNewsletterList
    throw UnimplementedError();
  }
}
