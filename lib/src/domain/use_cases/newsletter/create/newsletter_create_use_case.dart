import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:newsletter/src/core/helper/fcm_helper.dart';
import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository.dart';

import '../../../entities/newsletter.dart';

class NewsletterCreateUseCase {
  NewsletterCreateUseCase({required this.newsletterRepository});

  final NewsletterRepository newsletterRepository;

  Future<Result<void>> execute(Newsletter newsletter) async {
    try {
      final createNewsLetterResult =
          await newsletterRepository.createNewsletter(newsletter);

      try {
        if (await InternetConnection().hasInternetAccess) {
          await FCMHelper.sendNotificationToTopic(
              topic: 'newsletter',
              title: newsletter.title,
              body: newsletter.summary);
        }
      } catch (e) {
        debugPrint(e.toString());
      }

      return createNewsLetterResult;
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
