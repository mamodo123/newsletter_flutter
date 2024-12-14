import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsletter/src/presentation/newsletter/view_models/newsletter_internet_view_model.dart';
import 'package:newsletter/src/presentation/newsletter/view_models/newsletter_view_model.dart';
import 'package:newsletter/src/presentation/widgets/scaffold.dart';

import '../../../core/routing/routes.dart';
import '../../widgets/connection_state.dart';
import '../../widgets/newsletter_list_widget.dart';

class NewsletterListScreen extends StatelessWidget {
  const NewsletterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Newsletter List',
      body: Builder(builder: (context) {
        final isHybrid = Get.find<bool>();
        return Column(
          children: [
            if (isHybrid)
              GetBuilder<NewsletterInternetViewModel>(
                  builder: (internetController) {
                return Obx(() => ConnectionStateWidget(
                      connectionState: internetController.connectionState.value,
                    ));
              }),
            Expanded(
              child: GetBuilder<NewsletterViewModel>(builder: (controller) {
                return Obx(() => controller.loading.value
                    ? Center(
                        child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          Text('Loading newsletter'),
                        ],
                      ))
                    : NewsletterListWidget(
                        newsletterList: controller.newsletters,
                      ));
              }),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreateNewsletterScreen,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _goToCreateNewsletterScreen() async {
    await Get.toNamed(Routes.createNewsletter);
  }
}
