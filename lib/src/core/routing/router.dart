import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:newsletter/src/presentation/newsletter/view_models/newsletter_view_model.dart';

import '../../presentation/newsletter/widgets/create/newsletter_create_screen.dart';
import '../../presentation/newsletter/widgets/list/newsletter_list_screen.dart';
import 'routes.dart';

GoRouter router() => GoRouter(
      initialLocation: Routes.newsletter,
      routes: [
        GoRoute(
          path: Routes.newsletter,
          routes: [
            GoRoute(
              path: Routes.createNewsletter,
              builder: (context, state) {
                return const NewsletterCreateScreen();
              },
            ),
          ],
          builder: (context, state) {
            return GetBuilder<NewsletterViewModel>(
              init: NewsletterViewModel(
                newsletterCreateUseCase: Get.find(),
                newsletterRepository: Get.find(),
              ),
              builder: (controller) => const NewsletterListScreen(),
            );
          },
        ),
      ],
    );
