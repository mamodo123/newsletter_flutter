import 'dart:async';

import 'package:newsletter/src/core/helper/firebase_helper.dart';
import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/models/newsletter/newsletter_remote.dart';
import 'package:rxdart/rxdart.dart';

import 'newsletter_service_remote.dart';

class NewsletterServiceFirebase extends NewsletterServiceRemote {
  final String collectionPath;
  StreamSubscription? collectionStream;

  NewsletterServiceFirebase({required this.collectionPath})
      : super(BehaviorSubject<List<NewsletterRemote>>()) {
    connect();
  }

  @override
  Future<Result<String>> addNewsletter(NewsletterRemote newsletter,
      {notify = true}) async {
    await FirebaseHelper.initFirebase();
    final data = newsletter.toJson();
    final doc = await FirebaseHelper.insertDocument(collectionPath, data);
    if (notify &&
        !(subject.valueOrNull ?? [])
            .map((e) => e.uuid)
            .contains(newsletter.uuid)) {
      subject.add(List.unmodifiable([...subject.value, newsletter]));
    }
    return Result.ok(doc.id);
  }

  @override
  Stream<List<NewsletterRemote>> getNewsletterStream() {
    return subject.stream;
  }

  @override
  Future<Result<void>> connect() async {
    if (collectionStream != null) {
      return Result.ok(null);
    }
    try {
      collectionStream =
          FirebaseHelper.getCollectionStream(collectionPath).listen((data) {
        final newsletterMap = data.docs
            .map((e) =>
                NewsletterRemote.fromJson(json: e.data(), remoteId: e.id))
            .toList();
        subject.add(newsletterMap);
      });
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> disconnect() async {
    try {
      collectionStream?.cancel();
      collectionStream = null;
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  void dispose() {
    collectionStream?.cancel();
    super.dispose();
  }
}
