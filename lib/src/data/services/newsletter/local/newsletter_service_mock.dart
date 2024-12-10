import 'package:newsletter/src/data/models/newsletter/newsletter_local.dart';

import 'newsletter_service_local.dart';

class NewsletterServiceMock extends NewsletterServiceLocal {
  final items = List.generate(
    10,
    (index) => NewsletterLocal(
        title: 'Teste $index',
        category: 'Teste $index',
        summary: 'Teste $index',
        link: 'Teste $index',
        createdAt: DateTime.now(),
        synchronized: 0),
  );

  @override
  Future<List<NewsletterLocal>> getNewsletterList() async => items;

  @override
  Future<void> addNewsletter(NewsletterLocal newsletter) async {
    items.add(newsletter);
  }
}
