import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsletter/src/domain/entities/newsletter.dart';

import '../../core/routing/routes.dart';

class NewsletterListWidget extends StatelessWidget {
  final List<Newsletter> newsletterList;

  const NewsletterListWidget({super.key, required this.newsletterList});

  @override
  Widget build(BuildContext context) {
    if (newsletterList.isEmpty) {
      return const Center(
        child: Text('There are no registered newsletters yet'),
      );
    }
    return ListView.builder(
      itemCount: newsletterList.length,
      itemBuilder: (context, index) {
        var newsletter = newsletterList[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 4.0,
          child: ListTile(
            title: Text(newsletter.title),
            subtitle: Text(newsletter.summary),
            onTap: () => _seeNewsletter(newsletter),
          ),
        );
      },
    );
  }

  Future<void> _seeNewsletter(Newsletter newsletter) async {
    await Get.toNamed(Routes.seeNewsletter, arguments: newsletter);
  }
}
