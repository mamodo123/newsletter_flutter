import '../../../core/utils/result.dart';
import 'newsletter_repository.dart';

abstract class NewsletterRepositoryHybrid extends NewsletterRepository {
  NewsletterRepositoryHybrid(super.subject);

  Future<Result<void>> syncLocalAndRemote();
}
