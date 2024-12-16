import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:newsletter/src/core/config/databases/firebase_config.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_hybrid.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_hybrid_impl.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_local.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_remote.dart';
import 'package:newsletter/src/data/services/newsletter/local/newsletter_service_local.dart';
import 'package:newsletter/src/data/services/newsletter/local/newsletter_service_mock.dart';
import 'package:newsletter/src/data/services/newsletter/remote/newsletter_service_remote.dart';
import 'package:newsletter/src/data/services/newsletter/remote/newsletter_service_remote_mock.dart';
import 'package:newsletter/src/domain/use_cases/newsletter/create/newsletter_create_use_case.dart';
import 'package:newsletter/src/domain/use_cases/newsletter/create/newsletter_create_use_case_remote.dart';
import 'package:newsletter/src/domain/use_cases/newsletter/newsletter_sync_use_case.dart';

import '../../data/services/newsletter/local/newsletter_service_sqlite.dart';
import '../../data/services/newsletter/remote/newsletter_service_firebase.dart';
import '../helper/Internet_connection_mock.dart';
import 'databases/sqlite_config.dart';

// Shared Dependencies
void _sharedDependencies() {
  Get.lazyPut<bool>(
      () => Get.find<NewsletterRepository>() is NewsletterRepositoryHybrid);
}

// Bindings for Hybrid Providers
class HybridBindings extends Bindings {
  @override
  void dependencies() {
    // Services
    Get.lazyPut<NewsletterServiceLocal>(() => NewsletterServiceSqlite(
        dbPath: SQLiteConfig.dbPath,
        dbVersion: SQLiteConfig.dbVersion,
        onCreate: SQLiteConfig.onCreate));

    Get.lazyPut<NewsletterServiceRemote>(() =>
        NewsletterServiceFirebase(collectionPath: FirebaseConfig.collection));

    // Repositories
    Get.lazyPut<NewsletterRepository>(() => NewsletterRepositoryHybridImpl(
          newsletterServiceLocal: Get.find(),
          newsletterServiceRemote: Get.find(),
        ));

    Get.lazyPut<NewsletterCreateUseCase>(() => NewsletterCreateUseCaseRemote(
        newsletterRepository:
            Get.find<NewsletterRepository>() as NewsletterRepositoryRemote));

    // Specific Use Cases
    Get.lazyPut(() => NewsletterSyncUseCase(
          newsletterRepository:
              Get.find<NewsletterRepository>() as NewsletterRepositoryHybrid,
        ));

    // Internet connection
    Get.lazyPut(() => InternetConnection());

    // Shared Use Cases
    _sharedDependencies();
  }
}

// Bindings for Local Providers
class LocalBindings extends Bindings {
  @override
  void dependencies() {
    // Services
    Get.lazyPut<NewsletterServiceLocal>(() => NewsletterServiceSqlite(
        dbPath: SQLiteConfig.dbPath,
        dbVersion: SQLiteConfig.dbVersion,
        onCreate: SQLiteConfig.onCreate));

    // Repositories
    Get.lazyPut<NewsletterRepository>(() => NewsletterRepositoryLocal(
          newsletterServiceLocal: Get.find(),
        ));

    Get.lazyPut<NewsletterCreateUseCase>(
        () => NewsletterCreateUseCase(newsletterRepository: Get.find()));

    // Shared Use Cases
    _sharedDependencies();
  }
}

// Bindings for Remote Providers
class RemoteBindings extends Bindings {
  @override
  void dependencies() {
    // Services
    Get.lazyPut<NewsletterServiceRemote>(() =>
        NewsletterServiceFirebase(collectionPath: FirebaseConfig.collection));

    // Repositories
    Get.lazyPut<NewsletterRepository>(() => NewsletterRepositoryRemote(
          newsletterServiceRemote: Get.find(),
        ));

    Get.lazyPut<NewsletterCreateUseCase>(() => NewsletterCreateUseCaseRemote(
        newsletterRepository:
            Get.find<NewsletterRepository>() as NewsletterRepositoryRemote));

    // Shared Use Cases
    _sharedDependencies();
  }
}

class HybridMockBindings extends Bindings {
  @override
  void dependencies() {
    // Services
    Get.lazyPut<NewsletterServiceLocal>(() => NewsletterServiceMock());

    Get.lazyPut<NewsletterServiceRemote>(() => NewsletterServiceRemoteMock());

    // Repositories
    Get.lazyPut<NewsletterRepository>(() => NewsletterRepositoryHybridImpl(
          newsletterServiceLocal: Get.find(),
          newsletterServiceRemote: Get.find(),
        ));

    Get.lazyPut<NewsletterCreateUseCase>(() => NewsletterCreateUseCaseRemote(
        newsletterRepository:
            Get.find<NewsletterRepository>() as NewsletterRepositoryRemote));

    // Specific Use Cases
    Get.lazyPut(() => NewsletterSyncUseCase(
          newsletterRepository:
              Get.find<NewsletterRepository>() as NewsletterRepositoryHybrid,
        ));

    // Internet connection
    Get.lazyPut<InternetConnection>(() => InternetConnectionMock());

    // Shared Use Cases
    _sharedDependencies();
  }
}
