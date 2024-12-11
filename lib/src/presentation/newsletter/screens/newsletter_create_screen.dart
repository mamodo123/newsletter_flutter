import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsletter/src/domain/entities/newsletter.dart';
import 'package:newsletter/src/presentation/widgets/scaffold.dart';

import '../../../core/utils/validators.dart';
import '../view_models/newsletter_view_model.dart';

class NewsletterCreateScreen extends StatefulWidget {
  const NewsletterCreateScreen({super.key});

  @override
  State<NewsletterCreateScreen> createState() => _NewsletterCreateScreenState();
}

class _NewsletterCreateScreenState extends State<NewsletterCreateScreen> {
  late final TextEditingController titleTEC, categoryTEC, summaryTEC, linkTEC;

  @override
  void initState() {
    titleTEC = TextEditingController();
    categoryTEC = TextEditingController();
    summaryTEC = TextEditingController();
    linkTEC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleTEC.dispose();
    categoryTEC.dispose();
    summaryTEC.dispose();
    linkTEC.dispose();
    super.dispose();
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int? maxLines = 1,
      int? maxLength,
      bool showCounter = false,
      String? Function(String?)? validator}) {
    return TextFormField(
      maxLines: maxLines,
      maxLength: maxLength,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        counterText: showCounter ? null : '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return MyScaffold(
      title: 'Create Newsletter',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(
                    titleTEC,
                    'Title',
                    maxLength: 100,
                    validator: Validators.validateTitle,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    categoryTEC,
                    'Category',
                    maxLength: 100,
                    validator: Validators.validateCategory,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    summaryTEC,
                    'Summary',
                    maxLines: null,
                    maxLength: 500,
                    showCounter: true,
                    validator: Validators.validateSummary,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(linkTEC, 'Link',
                      maxLength: 100, validator: Validators.validateLink),
                  const SizedBox(height: 20),
                  GetBuilder<NewsletterViewModel>(
                    builder: (controller) => Obx(() {
                      return ElevatedButton(
                        onPressed: controller.createNewsletter.running.value
                            ? null
                            : () => _submitForm(context, formKey),
                        child: controller.createNewsletter.running.value
                            ? const CircularProgressIndicator()
                            : const Text('Create'),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm(BuildContext context, GlobalKey<FormState> formKey) async {
    final controller = Get.find<NewsletterViewModel>();

    if (formKey.currentState?.validate() ?? false) {
      final title = titleTEC.text;
      final category = categoryTEC.text;
      final summary = summaryTEC.text;
      final link = linkTEC.text;
      final newsletter = Newsletter(
        title: title,
        category: category,
        summary: summary,
        link: link,
        createdAt: DateTime.now(),
      );
      await controller.createNewsletter.execute(newsletter);
      if (controller.createNewsletter.error) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Error in creating newsletter'),
          ));
        }
      } else {
        Get.back();
      }
    }
  }
}
