import 'package:newsletter/src/core/helper/firebase_helper.dart';
import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_hybrid.dart';

class NewsletterSyncUseCase {
  NewsletterSyncUseCase(
      {required NewsletterRepositoryHybrid newsletterRepository})
      : _newsletterRepository = newsletterRepository;

  final NewsletterRepositoryHybrid _newsletterRepository;

  Future<Result<void>> onConnect() async {
    try {
      await FirebaseHelper.initFirebase();
      await _newsletterRepository.syncRemoteWithLocal();
      await _newsletterRepository.connectToRemote();
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> onDisconnect() async {
    return await _newsletterRepository.disconnectFromRemote();
  }
}
