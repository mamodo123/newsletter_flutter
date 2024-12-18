import 'package:rxdart/rxdart.dart';

import '../../../core/utils/result.dart';
import '../../../domain/entities/newsletter.dart';
import '../../models/newsletter/newsletter_local.dart';
import '../../services/newsletter/local/newsletter_service_local.dart';
import 'newsletter_repository.dart';

class NewsletterRepositoryLocal extends NewsletterRepository {
  final NewsletterServiceLocal newsletterServiceLocal;

  NewsletterRepositoryLocal({required this.newsletterServiceLocal})
      : super(BehaviorSubject<Result<List<Newsletter>>>.seeded(
            const Result.loading())) {
    newsletterServiceLocal.getNewsletterStream().listen((newsletterList) {
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
  }

  @override
  Future<Result<void>> createNewsletter(Newsletter newsletter) async {
    try {
      await newsletterServiceLocal.addNewsletter(NewsletterLocal(
        title: newsletter.title,
        category: newsletter.category,
        summary: newsletter.summary,
        link: newsletter.link,
        createdAt: newsletter.createdAt,
        uuid: newsletter.uuid,
        remote: null,
      ));
      return const Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  void dispose() {
    newsletterServiceLocal.dispose();
    super.dispose();
  }
}
