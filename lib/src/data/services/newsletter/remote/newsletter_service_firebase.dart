import 'dart:async';

import 'package:newsletter/src/data/models/newsletter/newsletter_remote.dart';

import 'newsletter_service_remote.dart';

class NewsletterServiceFirebase extends NewsletterServiceRemote {
  @override
  Stream<List<NewsletterRemote>> getNewsletterStream() {
    // TODO: implement getNewsletterStream
    throw UnimplementedError();
  }

  @override
  Future<void> addNewsletter(NewsletterRemote newsletter) {
    // TODO: implement addNewsletter
    throw UnimplementedError();
  }
}
