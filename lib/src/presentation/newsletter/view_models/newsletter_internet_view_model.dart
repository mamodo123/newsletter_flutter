import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:newsletter/src/domain/use_cases/newsletter/newsletter_sync_use_case.dart';

enum ConnectionState { offline, online, synchronizing }

class NewsletterInternetViewModel extends GetxController {
  final NewsletterSyncUseCase newsletterSyncUseCase;

  final connectionState = ConnectionState.offline.obs;

  NewsletterInternetViewModel({required this.newsletterSyncUseCase}) {
    InternetConnection().onStatusChange.listen((event) async {
      switch (event) {
        case InternetStatus.connected:
          connectionState.value = ConnectionState.synchronizing;
          await newsletterSyncUseCase.onConnect();
          connectionState.value = ConnectionState.online;
          break;
        case InternetStatus.disconnected:
          newsletterSyncUseCase.onDisconnect();
          connectionState.value = ConnectionState.offline;
          break;
      }
    });
  }
}
