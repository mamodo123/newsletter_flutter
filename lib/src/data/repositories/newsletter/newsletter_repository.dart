import 'package:rxdart/rxdart.dart';

import '../../../core/utils/result.dart';
import '../../../domain/entities/newsletter.dart';

abstract class NewsletterRepository {
  final BehaviorSubject<Result<List<Newsletter>>> subject;

  NewsletterRepository(this.subject);

  Stream<Result<List<Newsletter>>> getNewsletterStream();

  Future<Result<void>> createNewsletter(Newsletter newsletter);
}
