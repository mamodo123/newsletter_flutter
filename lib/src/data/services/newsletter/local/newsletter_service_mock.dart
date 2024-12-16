import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../../models/newsletter/newsletter_local.dart';
import 'newsletter_service_local.dart';

class NewsletterServiceMock extends NewsletterServiceLocal {
  final List<NewsletterLocal> _items = List.generate(
    10,
    (index) => NewsletterLocal(
      title: 'Test $index',
      category: 'Test $index',
      summary: 'Test $index',
      link: 'Test $index',
      createdAt: DateTime.now(),
      remote: null,
      uuid: Uuid().v4(),
    ),
  );

  NewsletterServiceMock() : super(BehaviorSubject<List<NewsletterLocal>>()) {
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

  @override
  Future<void> updateRemotes(List<NewsletterLocal> newsletterList) async {
    final validRemotes = newsletterList
        .map((e) => e.remote)
        .whereType<String>()
        .where((e) => e.isNotEmpty)
        .toList();
    _items.removeWhere(
        (item) => item.remote != null && !validRemotes.contains(item.remote));

    for (final newsletter in newsletterList) {
      final existingIndex = _items.indexWhere((e) => e.uuid == newsletter.uuid);
      if (existingIndex != -1) {
        _items[existingIndex] = newsletter;
      } else {
        _items.add(newsletter);
      }
    }

    subject.add(List.unmodifiable(_items));
  }

  @override
  Future<List<NewsletterLocal>> getNonSynchronized() async {
    return _items.where((e) => e.remote == null).toList();
  }

  @override
  Future<void> updateNewsletterRemote(
      {required String uuid, required String remoteId}) async {
    final itemIndex = _items.indexWhere((e) => e.uuid == uuid);
    final item = _items[itemIndex];
    _items[itemIndex] = NewsletterLocal(
        title: item.title,
        category: item.category,
        summary: item.summary,
        link: item.link,
        createdAt: item.createdAt,
        uuid: item.uuid,
        remote: remoteId);
  }
}
