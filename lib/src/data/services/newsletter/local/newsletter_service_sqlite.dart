import 'package:newsletter/src/data/models/newsletter/newsletter_local.dart';

import 'newsletter_service_local.dart';

 class NewsletterServiceSqlite extends NewsletterServiceLocal {
  @override
  Future<void> addNewsletter(NewsletterLocal newsletter) {
    // TODO: implement addNewsletter
    throw UnimplementedError();
  }

  @override
  Future<List<NewsletterLocal>> getNewsletterList() {
    // TODO: implement getNewsletterList
    throw UnimplementedError();
  }
}
