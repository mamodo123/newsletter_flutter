import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_remote.dart';

import '../../../core/utils/result.dart';
import '../../models/newsletter/newsletter_local.dart';

abstract class NewsletterRepositoryHybrid extends NewsletterRepositoryRemote {
  NewsletterRepositoryHybrid({required super.newsletterServiceRemote});

  Future<Result<void>> syncRemoteWithLocal();

  Future<Result<void>> syncLocalWithList(List<NewsletterLocal> newsletterList);

  Future<Result<void>> connectToRemote();

  Future<Result<void>> disconnectFromRemote();
}
