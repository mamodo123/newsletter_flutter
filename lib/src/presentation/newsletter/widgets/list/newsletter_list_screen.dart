import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsletter/src/presentation/newsletter/view_models/newsletter_view_model.dart';

class NewsletterListScreen extends StatelessWidget {
  const NewsletterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Newsletter List'),
      ),
      body: GetBuilder<NewsletterViewModel>(
        builder: (controller) {
          return Container(
            color: Colors.blue,
            child: Center(
              child: Text(
                'Newsletter Count: ${controller.newsletters.length}',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}
