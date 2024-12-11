import 'dart:async';

import 'package:get/get.dart';
import 'package:newsletter/src/core/utils/command.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository.dart';
import 'package:newsletter/src/domain/entities/newsletter.dart';

import '../../../core/utils/result.dart';
import '../../../domain/use_cases/newsletter/newsletter_create_use_case.dart';

class NewsletterViewModel extends GetxController {
  final NewsletterCreateUseCase _newsletterCreateUseCase;

  final NewsletterRepository _newsletterRepository;

  late final Command1<void, Newsletter> createNewsletter;

  final RxList<Newsletter> newsletters = <Newsletter>[].obs;

  StreamSubscription? _newsletterStreamSubscription;

  NewsletterViewModel({
    required NewsletterCreateUseCase newsletterCreateUseCase,
    required NewsletterRepository newsletterRepository,
  })  : _newsletterCreateUseCase = newsletterCreateUseCase,
        _newsletterRepository = newsletterRepository {
    createNewsletter = Command1(_createNewsletter);
  }

  @override
  void onInit() {
    super.onInit();
    _listenToNewsletterStream();
  }

  @override
  void onClose() {
    _newsletterStreamSubscription?.cancel();
    super.onClose();
  }

  Future<Result<void>> _createNewsletter(Newsletter newsletter) async {
    return await _newsletterCreateUseCase.execute(newsletter);
  }

  Future<void> _listenToNewsletterStream() async {
    _newsletterStreamSubscription =
        _newsletterRepository.getNewsletterStream().listen((result) {
      switch (result) {
        case Ok():
          newsletters.assignAll(result.value);
          break;
        case Error():
          //TODO show error
          break;
      }
    }, onError: (error) {
      //TODO show error
    });
  }
}
