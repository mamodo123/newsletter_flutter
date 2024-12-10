import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository.dart';

import '../../entities/newsletter.dart';

class NewsletterCreateUseCase {
  NewsletterCreateUseCase({required NewsletterRepository newsletterRepository})
      : _newsletterRepository = newsletterRepository;

  final NewsletterRepository _newsletterRepository;

  Future<Result<void>> execute(Newsletter newsletter) async {
    try {
      return await _newsletterRepository.createNewsletter(newsletter);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
