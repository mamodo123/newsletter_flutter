import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_models/newsletter_view_model.dart';

class NewsletterCreateScreen extends StatefulWidget {
  const NewsletterCreateScreen({super.key});

  @override
  State<NewsletterCreateScreen> createState() => _NewsletterCreateScreenState();
}

class _NewsletterCreateScreenState extends State<NewsletterCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsletterViewModel>(builder: (controller) {
      return Container(
        color: Colors.blue,
      );
    });
  }
}
