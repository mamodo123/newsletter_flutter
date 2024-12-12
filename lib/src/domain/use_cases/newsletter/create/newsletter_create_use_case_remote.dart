import 'package:flutter/material.dart';
import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_remote.dart';

import '../../../entities/newsletter.dart';
import 'newsletter_create_use_case.dart';

class NewsletterCreateUseCaseRemote extends NewsletterCreateUseCase {
  NewsletterCreateUseCaseRemote(
      {required NewsletterRepositoryRemote newsletterRepository})
      : super(newsletterRepository: newsletterRepository);

  @override
  Future<Result<void>> execute(Newsletter newsletter) async {
    try {
      final createNewsletterResult =
          await newsletterRepository.createNewsletter(newsletter);

      try {
        // TODO Call FCM here
      } catch (e) {
        debugPrint(e.toString());
      }

      return createNewsletterResult;
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
