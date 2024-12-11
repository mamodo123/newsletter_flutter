import 'package:newsletter/src/core/utils/result.dart';
import 'package:newsletter/src/data/services/newsletter/local/newsletter_service_local.dart';
import 'package:newsletter/src/data/services/newsletter/remote/newsletter_service_remote.dart';

import '../../../domain/entities/newsletter.dart';
import 'newsletter_repository_hybrid.dart';

class NewsletterRepositoryHybridImpl implements NewsletterRepositoryHybrid {
  final NewsletterServiceLocal newsletterServiceLocal;
  final NewsletterServiceRemote newsletterServiceRemote;

  NewsletterRepositoryHybridImpl(
      {required this.newsletterServiceLocal,
      required this.newsletterServiceRemote});

  @override
  Future<Result<void>> createNewsletter(Newsletter newsletter) {
    // TODO: implement createNewsletter
    throw UnimplementedError();
  }

  @override
  Stream<Result<List<Newsletter>>> getNewsletterStream() {
    // TODO: implement getNewsletterList
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> syncLocalAndRemote() {
    // TODO: implement syncLocalAndRemote
    throw UnimplementedError();
  }
}
