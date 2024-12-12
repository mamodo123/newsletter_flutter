import 'package:get/get.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_hybrid.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_hybrid_impl.dart';
import 'package:newsletter/src/data/repositories/newsletter/newsletter_repository_local.dart';
import 'package:newsletter/src/data/services/newsletter/local/newsletter_service_local.dart';
import 'package:newsletter/src/data/services/newsletter/remote/newsletter_service_remote.dart';
import 'package:newsletter/src/domain/use_cases/newsletter/newsletter_create_use_case.dart';
import 'package:newsletter/src/domain/use_cases/newsletter/newsletter_sync_use_case.dart';

import '../../data/services/newsletter/local/newsletter_service_sqlite.dart';
import '../../data/services/newsletter/remote/newsletter_service_firebase.dart';
import 'databases/sqlite_config.dart';

// Shared Dependencies
void _sharedDependencies() {
  Get.lazyPut(() => NewsletterCreateUseCase(newsletterRepository: Get.find()));
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
    Get.lazyPut<NewsletterServiceRemote>(() => NewsletterServiceFirebase());

    // Repositories
    Get.lazyPut<NewsletterRepository>(() => NewsletterRepositoryHybridImpl(
          newsletterServiceLocal: Get.find(),
          newsletterServiceRemote: Get.find(),
        ));

    // Shared Use Cases
    _sharedDependencies();

    // Specific Use Cases
    Get.lazyPut(() => NewsletterSyncUseCase(
          newsletterRepository:
              Get.find<NewsletterRepository>() as NewsletterRepositoryHybrid,
        ));
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

    // Shared Use Cases
    _sharedDependencies();
  }
}
