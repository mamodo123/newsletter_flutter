import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsletter/src/presentation/newsletter/view_models/newsletter_view_model.dart';
import 'package:newsletter/src/presentation/widgets/scaffold.dart';

import '../../../core/routing/routes.dart';

class NewsletterListScreen extends StatelessWidget {
  const NewsletterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Newsletter List',
      body: GetBuilder<NewsletterViewModel>(
        builder: (controller) {
          return Obx(
            () {
              return ListView.builder(
                itemCount: controller.newsletters.length,
                itemBuilder: (context, index) {
                  var newsletter = controller.newsletters[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 4.0,
                    child: ListTile(
                      title: Text(newsletter.title),
                      subtitle: Text(newsletter.summary),
                      onTap: () {
                        Get.toNamed(Routes.seeNewsletter, arguments: newsletter);
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed(Routes.createNewsletter);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
