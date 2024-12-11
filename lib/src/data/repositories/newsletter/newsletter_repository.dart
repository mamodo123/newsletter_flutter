import '../../../core/utils/result.dart';
import '../../../domain/entities/newsletter.dart';

abstract class NewsletterRepository {

  Stream<Result<List<Newsletter>>> getNewsletterStream();

  Future<Result<void>> createNewsletter(Newsletter newsletter);
}
