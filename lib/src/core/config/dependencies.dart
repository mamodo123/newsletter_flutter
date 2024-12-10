import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_hybrid.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_hybrid_impl.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_local.dart';
import 'package:newsletter/src/data/services/newsletter/local/newsletter_service_local.dart';
import 'package:newsletter/src/data/services/newsletter/local/newsletter_service_mock.dart';
import 'package:newsletter/src/data/services/newsletter/remote/newsletter_service_remote.dart';
import 'package:newsletter/src/domain/use_cases/newsletter/newsletter_create_use_case.dart';
import 'package:newsletter/src/domain/use_cases/newsletter/newsletter_get_use_case.dart';
import 'package:newsletter/src/domain/use_cases/newsletter/newsletter_sync_use_case.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/services/newsletter/local/newsletter_service_sqlite.dart';
import '../../data/services/newsletter/remote/newsletter_service_firebase.dart';

List<SingleChildWidget> _sharedProviders = [
  Provider(
    lazy: true,
    create: (context) => NewsletterGetUseCase(
      newsletterRepository: context.read(),
    ),
  ),
  Provider(
    lazy: true,
    create: (context) => NewsletterCreateUseCase(
      newsletterRepository: context.read(),
    ),
  ),
];

List<SingleChildWidget> get providersHybrid => [
      Provider<NewsletterServiceLocal>(
          create: (context) => NewsletterServiceSqlite()),
      Provider<NewsletterServiceRemote>(
          create: (context) => NewsletterServiceFirebase()),
      Provider<NewsletterRepository>(
        create: (context) => NewsletterRepositoryHybridImpl(
            newsletterServiceLocal: context.read(),
            newsletterServiceRemote: context.read()),
      ),
      ..._sharedProviders,
      Provider(
        lazy: true,
        create: (context) => NewsletterSyncUseCase(
          newsletterRepository: context.read<NewsletterRepository>()
              as NewsletterRepositoryHybrid,
        ),
      ),
    ];

List<SingleChildWidget> get providersLocal => [
      Provider<NewsletterServiceLocal>(
          create: (context) => NewsletterServiceMock()),
      Provider<NewsletterRepository>(
          create: (context) => NewsletterRepositoryLocal(
              newsletterServiceLocal: context.read())),
      ..._sharedProviders,
    ];
