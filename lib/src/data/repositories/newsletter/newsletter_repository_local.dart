import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/models/newsletter/newsletter_local.dart';
import 'package:newsletter/src/data/services/newsletter/local/newsletter_service_local.dart';
import '../../../domain/entities/newsletter.dart';
import 'newsletter_repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsletterRepositoryLocal implements NewsletterRepository {
  final NewsletterServiceLocal newsletterServiceLocal;

  NewsletterRepositoryLocal({required this.newsletterServiceLocal});

  @override
  Future<Result<void>> createNewsletter(Newsletter newsletter) async {
    try {
      await newsletterServiceLocal.addNewsletter(NewsletterLocal(
        title: newsletter.title,
        category: newsletter.category,
        summary: newsletter.summary,
        link: newsletter.link,
        createdAt: newsletter.createdAt,
        synchronized: 0,
      ));
      return const Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Stream<Result<List<Newsletter>>> getNewsletterStream() {
    return newsletterServiceLocal.getNewsletterStream().map((newsletterList) {
      return Result.ok(newsletterList
          .map((e) => Newsletter(
        title: e.title,
        category: e.category,
        summary: e.summary,
        link: e.link,
        createdAt: e.createdAt,
      ))
          .toList());
    }).handleError((error) {
      return Result.error(error);
    });
  }
}
