import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/models/newsletter/newsletter_remote.dart';

import '../../../domain/entities/newsletter.dart';
import '../../services/newsletter/remote/newsletter_service_remote.dart';
import 'newsletter_repository.dart';

class NewsletterRepositoryRemote implements NewsletterRepository {
  final NewsletterServiceRemote newsletterServiceRemote;

  NewsletterRepositoryRemote({required this.newsletterServiceRemote});

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
  Future<Result<List<Newsletter>>> getNewsletterList() async {
    try {
      return Result.ok((await newsletterServiceRemote.getNewsletterList())
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
