import 'package:get/get.dart';
import 'package:newsletter/src/core/routing/routes.dart';

import '../../presentation/newsletter/screens/newsletter_create_screen.dart';
import '../../presentation/newsletter/screens/newsletter_list_screen.dart';
import '../../presentation/newsletter/screens/newsletter_screen.dart';
import '../../presentation/newsletter/view_models/newsletter_internet_view_model.dart';
import '../../presentation/newsletter/view_models/newsletter_view_model.dart';

List<GetPage> appRoutes = [
  GetPage(
    name: Routes.newsletter,
    page: () => const NewsletterListScreen(),
    binding: BindingsBuilder(() {
      Get.put(
        NewsletterViewModel(
          newsletterCreateUseCase: Get.find(),
          newsletterRepository: Get.find(),
        ),
      );
      if (Get.find<bool>()) {
        Get.put(
          NewsletterInternetViewModel(
            newsletterSyncUseCase: Get.find(),
          ),
        );
      }
    }),
    children: [
      GetPage(
        name: Routes.createNewsletter,
        page: () => const NewsletterCreateScreen(),
      ),
      GetPage(
        name: Routes.seeNewsletter,
        page: () => NewsletterDetailsScreen(
          newsletter: Get.arguments,
        ),
      ),
    ],
  ),
];
