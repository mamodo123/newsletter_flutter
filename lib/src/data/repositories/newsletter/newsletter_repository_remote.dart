import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/models/newsletter/newsletter_remote.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/newsletter.dart';
import '../../services/newsletter/remote/newsletter_service_remote.dart';
import 'newsletter_repository.dart';

class NewsletterRepositoryRemote extends NewsletterRepository {
  final NewsletterServiceRemote newsletterServiceRemote;

  NewsletterRepositoryRemote({required this.newsletterServiceRemote})
      : super(BehaviorSubject<Result<List<Newsletter>>>.seeded(
            [] as Result<List<Newsletter>>));

  @override
  Future<Result<void>> createNewsletter(Newsletter newsletter) async {
    try {
      await newsletterServiceRemote.addNewsletter(NewsletterRemote(
          title: newsletter.title,
          category: newsletter.category,
          summary: newsletter.summary,
          link: newsletter.link,
          createdAt: newsletter.createdAt));
      return const Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Stream<Result<List<Newsletter>>> getNewsletterStream() {
    return newsletterServiceRemote.getNewsletterStream().map((newsletterList) {
      return Result.ok(newsletterList
          .map((e) => Newsletter(
              title: e.title,
              category: e.category,
              summary: e.summary,
              link: e.link,
              createdAt: e.createdAt))
          .toList());
    }).handleError((error) {
      return Result.error(error);
    });
  }
}
