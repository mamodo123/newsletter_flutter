import '../../../core/utils/result.dart';
import 'newsletter_repository.dart';

abstract class NewsletterRepositoryHybrid extends NewsletterRepository {
  Future<Result<void>> syncLocalAndRemote();
}
