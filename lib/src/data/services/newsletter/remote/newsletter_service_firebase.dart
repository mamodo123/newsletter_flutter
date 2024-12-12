import 'dart:async';

import 'package:newsletter/src/core/helper/firebase_helper.dart';
import 'package:newsletter/src/data/models/newsletter/newsletter_remote.dart';
import 'package:rxdart/rxdart.dart';

import 'newsletter_service_remote.dart';

class NewsletterServiceFirebase extends NewsletterServiceRemote {
  final String collectionPath;
  late final StreamSubscription collectionStream;

  NewsletterServiceFirebase({required this.collectionPath})
      : super(BehaviorSubject<List<NewsletterRemote>>.seeded([])) {
    collectionStream =
        FirebaseHelper.getCollectionStream(collectionPath).listen((data) {
      final newsletterMap = data.docs
          .map((e) => NewsletterRemote.fromJson(json: e.data()))
          .toList();
      subject.add(newsletterMap);
    });
  }

  @override
  Future<void> addNewsletter(NewsletterRemote newsletter) async {
    final data = newsletter.toJson();
    await FirebaseHelper.insertDocument(collectionPath, data);
    subject.add(List.unmodifiable([...subject.value, newsletter]));
  }

  @override
  Stream<List<NewsletterRemote>> getNewsletterStream() {
    return subject.stream;
  }

  @override
  void dispose() {
    collectionStream.cancel();
    super.dispose();
  }
}
