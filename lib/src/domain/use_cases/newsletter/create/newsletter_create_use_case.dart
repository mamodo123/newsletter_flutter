import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository.dart';

import '../../../entities/newsletter.dart';

class NewsletterCreateUseCase {
  NewsletterCreateUseCase({required this.newsletterRepository});

  final NewsletterRepository newsletterRepository;

  Future<Result<void>> execute(Newsletter newsletter) async {
    return await newsletterRepository.createNewsletter(newsletter);
  }
}
