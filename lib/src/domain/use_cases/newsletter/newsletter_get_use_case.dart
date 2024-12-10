import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository.dart';

import '../../entities/newsletter.dart';

class NewsletterGetUseCase {
  NewsletterGetUseCase({required NewsletterRepository newsletterRepository})
      : _newsletterRepository = newsletterRepository;

  final NewsletterRepository _newsletterRepository;

  Future<Result<List<Newsletter>>> execute() async {
    try {
      return await _newsletterRepository.getNewsletterList();
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
