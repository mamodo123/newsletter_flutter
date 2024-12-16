import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/models/newsletter/newsletter_remote.dart';
import 'package:newsletter/src/data/services/newsletter/remote/newsletter_service_remote.dart';
import 'package:rxdart/rxdart.dart';

class NewsletterServiceRemoteMock extends NewsletterServiceRemote {
  final Map<String, NewsletterRemote> _items = {};

  Map<String, NewsletterRemote> get items => _items;

  NewsletterServiceRemoteMock()
      : super(BehaviorSubject<List<NewsletterRemote>>());

  @override
  Stream<List<NewsletterRemote>> getNewsletterStream() {
    return subject.stream;
  }

  @override
  Future<Result<String>> addNewsletter(NewsletterRemote newsletter,
      {bool notify = true}) async {
    _items[newsletter.uuid] = newsletter;
    if (notify &&
        !(subject.valueOrNull ?? [])
            .map((e) => e.uuid)
            .contains(newsletter.uuid)) {
      subject.add(List.unmodifiable(_items.values.toList()));
    }
    return Result.ok(newsletter.uuid);
  }

  @override
  Future<Result<void>> connect() async {
    await Future.delayed(Duration(seconds: 2));
    return Result.ok(null);
  }

  @override
  Future<Result<void>> disconnect() async {
    return Result.ok(null);
  }
}
