import 'package:rxdart/rxdart.dart';

import '../../../core/utils/result.dart';
import '../../../domain/entities/newsletter.dart';

abstract class NewsletterRepository {
  final BehaviorSubject<Result<List<Newsletter>>> subject;

  Stream<Result<List<Newsletter>>> get stream => subject.stream;

  NewsletterRepository(this.subject);

  Future<Result<void>> createNewsletter(Newsletter newsletter);

  void dispose() {
    subject.close();
  }
}
