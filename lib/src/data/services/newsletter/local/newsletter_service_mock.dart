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
      synchronized: 0,
    ),
  );

  final BehaviorSubject<List<NewsletterLocal>> _subject =
      BehaviorSubject<List<NewsletterLocal>>.seeded([]);

  NewsletterServiceMock() {
    _subject.add(List.unmodifiable(_items));
  }

  @override
  Stream<List<NewsletterLocal>> getNewsletterStream() {
    return _subject.stream;
  }

  @override
  Future<void> addNewsletter(NewsletterLocal newsletter) async {
    _items.add(newsletter);
    _subject.add(List.unmodifiable(_items));
  }

  void dispose() {
    _subject.close();
  }
}
