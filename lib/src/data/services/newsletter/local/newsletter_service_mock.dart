import 'package:rxdart/rxdart.dart';

import '../../../models/newsletter/newsletter_local.dart';
import 'newsletter_service_local.dart';

class NewsletterServiceMock extends NewsletterServiceLocal {
  final List<NewsletterLocal> _items = List.generate(
    10,
    (index) => NewsletterLocal(
      title: 'Teste $index',
      category: 'Teste $index',
      summary: 'Teste $index',
      link: 'Teste $index',
      createdAt: DateTime.now(),
      remote: null,
    ),
  );

  NewsletterServiceMock()
      : super(BehaviorSubject<List<NewsletterLocal>>.seeded([])) {
    subject.add(List.unmodifiable(_items));
  }

  @override
  Stream<List<NewsletterLocal>> getNewsletterStream() {
    return subject.stream;
  }

  @override
  Future<void> addNewsletter(NewsletterLocal newsletter) async {
    _items.add(newsletter);
    subject.add(List.unmodifiable(_items));
  }

}
