import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/models/newsletter/newsletter_remote.dart';
import 'package:newsletter/src/data/services/newsletter/local/newsletter_service_local.dart';

import '../../../domain/entities/newsletter.dart';
import '../../models/newsletter/newsletter_local.dart';
import 'newsletter_repository_hybrid.dart';

class NewsletterRepositoryHybridImpl extends NewsletterRepositoryHybrid {
  final NewsletterServiceLocal newsletterServiceLocal;

  late final StreamSubscription<List<NewsletterLocal>>
      newsletterLocalStreamSubscription;
  StreamSubscription<List<NewsletterRemote>>?
      newsletterRemoteLocalStreamSubscription;

  NewsletterRepositoryHybridImpl(
      {required this.newsletterServiceLocal,
      required super.newsletterServiceRemote})
      : super() {
    newsletterLocalStreamSubscription = newsletterServiceLocal
        .getNewsletterStream()
        .listen((newsletterList) async {
      subject.add(Result.ok(newsletterList
          .map<Newsletter>((e) => Newsletter(
                title: e.title,
                category: e.category,
                summary: e.summary,
                link: e.link,
                createdAt: e.createdAt,
                uuid: e.uuid,
              ))
          .toList()));
    });

    connectToRemote();
  }

  @override
  Future<Result<void>> createNewsletter(Newsletter newsletter) async {
    try {
      if (await Get.find<InternetConnection>().hasInternetAccess) {
        await newsletterServiceRemote.addNewsletter(NewsletterRemote(
          title: newsletter.title,
          category: newsletter.category,
          summary: newsletter.summary,
          link: newsletter.link,
          createdAt: newsletter.createdAt,
          uuid: newsletter.uuid,
          remoteId: null,
        ));
      } else {
        await newsletterServiceLocal.addNewsletter(NewsletterLocal(
          title: newsletter.title,
          category: newsletter.category,
          summary: newsletter.summary,
          link: newsletter.link,
          createdAt: newsletter.createdAt,
          uuid: newsletter.uuid,
          remote: null,
        ));
      }
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> connectToRemote() async {
    newsletterRemoteLocalStreamSubscription =
        newsletterServiceRemote.getNewsletterStream().listen((newsletterList) {
      syncLocalWithList(newsletterList
          .map((e) => NewsletterLocal(
                title: e.title,
                category: e.category,
                summary: e.summary,
                link: e.link,
                createdAt: e.createdAt,
                uuid: e.uuid,
                remote: e.remoteId,
              ))
          .toList());
    });
    return await newsletterServiceRemote.connect();
  }

  @override
  Future<Result<void>> disconnectFromRemote() async {
    try {
      await newsletterServiceRemote.disconnect();
      newsletterRemoteLocalStreamSubscription?.cancel();
      newsletterRemoteLocalStreamSubscription = null;
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> syncRemoteWithLocal() async {
    try {
      final notSynchronizedNewsletterLocal =
          await newsletterServiceLocal.getNonSynchronized();
      for (final newsletter in notSynchronizedNewsletterLocal) {
        final remoteIdResult = await newsletterServiceRemote.addNewsletter(
            NewsletterRemote(
                title: newsletter.title,
                category: newsletter.category,
                summary: newsletter.summary,
                link: newsletter.link,
                createdAt: newsletter.createdAt,
                uuid: newsletter.uuid,
                remoteId: null),
            notify: false);

        switch (remoteIdResult) {
          case Loading():
            //Impossible state
            break;
          case Ok():
            try {
              await newsletterServiceLocal.updateNewsletterRemote(
                  uuid: newsletter.uuid, remoteId: remoteIdResult.value);
            } on Exception catch (e) {
              debugPrint(e.toString());
            }
            break;
          case Error():
            debugPrint(remoteIdResult.error.toString());
        }
      }
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> syncLocalWithList(
      List<NewsletterLocal> newsletterList) async {
    try {
      await newsletterServiceLocal.updateRemotes(newsletterList);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  void dispose() {
    newsletterServiceLocal.dispose();
    newsletterServiceRemote.dispose();
    newsletterLocalStreamSubscription.cancel();
    newsletterRemoteLocalStreamSubscription?.cancel();
    super.dispose();
  }
}
