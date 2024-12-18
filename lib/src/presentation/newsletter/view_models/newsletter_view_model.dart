import 'dart:async';

import 'package:get/get.dart';
import 'package:newsletter/src/core/utils/command.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository.dart';
import 'package:newsletter/src/domain/entities/newsletter.dart';

import '../../../core/utils/result.dart';
import '../../../domain/use_cases/newsletter/create/newsletter_create_use_case.dart';

class NewsletterViewModel extends GetxController {
  final NewsletterCreateUseCase _newsletterCreateUseCase;

  final NewsletterRepository _newsletterRepository;

  late final Command1<void, Newsletter> createNewsletter;

  final RxList<Newsletter> newsletters = <Newsletter>[].obs;

  List<Newsletter> get newslettersFiltered {
    return newsletters;
  }

  late final StreamController<Error<List<Newsletter>>> _errorsStreamController;

  Stream<Error<List<Newsletter>>> get errorsStream =>
      _errorsStreamController.stream;

  final loading = true.obs;

  StreamSubscription? _newsletterStreamSubscription;

  NewsletterViewModel({
    required NewsletterCreateUseCase newsletterCreateUseCase,
    required NewsletterRepository newsletterRepository,
  })  : _newsletterCreateUseCase = newsletterCreateUseCase,
        _newsletterRepository = newsletterRepository {
    _errorsStreamController = StreamController<Error<List<Newsletter>>>();
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
        _newsletterRepository.stream.listen((result) {
      if (result is Loading) {
        loading.value = true;
      } else {
        loading.value = false;
        switch (result) {
          case Ok():
            newsletters.assignAll(result.value);
            break;
          case Error():
            _errorsStreamController.add(result);
            break;
          case Loading():
            loading.value = true;
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _errorsStreamController.close();
    _newsletterStreamSubscription?.cancel();
    super.dispose();
  }
}
