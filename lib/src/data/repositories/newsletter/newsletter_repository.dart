
import '../../../core/utils/result.dart';
import '../../../domain/entities/newsletter.dart';

abstract class NewsletterRepository {
  Future<Result<List<Newsletter>>> getNewsletterList();

  Future<Result<void>> createNewsletter(Newsletter newsletter);
}
