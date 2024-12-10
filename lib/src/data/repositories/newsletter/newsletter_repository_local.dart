import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/models/newsletter/newsletter_local.dart';
import 'package:newsletter/src/data/services/newsletter/local/newsletter_service_local.dart';

import '../../../domain/entities/newsletter.dart';
import 'newsletter_repository.dart';

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
          synchronized: 0));
      return const Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<Newsletter>>> getNewsletterList() async {
    try {
      return Result.ok((await newsletterServiceLocal.getNewsletterList())
          .map((e) => Newsletter(
              title: e.title,
              category: e.category,
              summary: e.summary,
              link: e.link,
              createdAt: e.createdAt))
          .toList());
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
