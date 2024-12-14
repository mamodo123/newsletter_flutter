import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsletter/src/presentation/newsletter/view_models/newsletter_internet_view_model.dart';
import 'package:newsletter/src/presentation/newsletter/view_models/newsletter_view_model.dart';
import 'package:newsletter/src/presentation/widgets/scaffold.dart';

import '../../../core/routing/routes.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/newsletter.dart';
import '../../widgets/connection_state.dart';
import '../../widgets/newsletter_list_widget.dart';

class NewsletterListScreen extends StatefulWidget {
  const NewsletterListScreen({super.key});

  @override
  State<NewsletterListScreen> createState() => _NewsletterListScreenState();
}

class _NewsletterListScreenState extends State<NewsletterListScreen> {
  late final StreamSubscription<Error<List<Newsletter>>>
      _errorStreamSubscription;

  @override
  void initState() {
    final controller = Get.find<NewsletterViewModel>();
    final errorStream = controller.errorsStream;
    _errorStreamSubscription = errorStream.listen((error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Some error occurred while receiving information'),
        ));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _errorStreamSubscription.cancel();
    super.dispose();
  }

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
