import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_hybrid.dart';

class NewsletterSyncUseCase {
  NewsletterSyncUseCase(
      {required NewsletterRepositoryHybrid newsletterRepository})
      : _newsletterRepository = newsletterRepository;

  final NewsletterRepositoryHybrid _newsletterRepository;

  Future<Result<void>> execute() async {
    try {
      return await _newsletterRepository.syncLocalAndRemote();
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
