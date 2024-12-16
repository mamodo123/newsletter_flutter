import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:newsletter/src/core/helper/Internet_connection_mock.dart';
import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_remote.dart';

import '../../../../core/helper/fcm_helper.dart';
import '../../../entities/newsletter.dart';
import 'newsletter_create_use_case.dart';

class NewsletterCreateUseCaseRemote extends NewsletterCreateUseCase {
  NewsletterCreateUseCaseRemote(
      {required NewsletterRepositoryRemote newsletterRepository})
      : super(newsletterRepository: newsletterRepository);

  @override
  Future<Result<void>> execute(Newsletter newsletter) async {
    try {
      final createNewsLetterResult =
          await newsletterRepository.createNewsletter(newsletter);

      try {
        final internetConnection = Get.find<InternetConnection>();
        if (internetConnection is! InternetConnectionMock &&
            await internetConnection.hasInternetAccess) {
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
