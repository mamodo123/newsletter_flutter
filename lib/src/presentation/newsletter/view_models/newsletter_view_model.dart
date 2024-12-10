import 'package:get/get.dart';
import 'package:newsletter/src/core/utils/command.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository.dart';
import 'package:newsletter/src/domain/entities/newsletter.dart';

import '../../../core/utils/result.dart';
import '../../../domain/use_cases/newsletter/newsletter_create_use_case.dart';

class NewsletterViewModel extends GetxController {
  final NewsletterCreateUseCase _newsletterCreateUseCase;
  late final Command1<void, Newsletter> createNewsLetter;

  final newsletters = [1, 2, 3];

  NewsletterViewModel(
      {required NewsletterCreateUseCase newsletterCreateUseCase,
      required NewsletterRepository newsletterRepository})
      : _newsletterCreateUseCase = newsletterCreateUseCase {
    createNewsLetter = Command1(_createNewsLetter);
  }

  Future<Result<void>> _createNewsLetter(Newsletter newsletter) async {
    final createdNewsletterResult =
        await _newsletterCreateUseCase.execute(newsletter);
    if (createdNewsletterResult is Error<void>) {
      return Result.error(createdNewsletterResult.error);
    }
    return const Result.ok(null);
  }
}
