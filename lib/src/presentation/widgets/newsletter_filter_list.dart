import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsletter/src/presentation/newsletter/view_models/newsletter_filter_view_model.dart';

import 'newsletter_list_widget.dart';

class NewsletterFilterList extends StatelessWidget {
  const NewsletterFilterList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsletterFilterViewModel>(
      builder: (controller) => Column(
        children: [
          FilterSection(controller: controller),
          Expanded(
            child: NewsletterContent(controller: controller),
          ),
        ],
      ),
    );
  }
}

class FilterSection extends StatelessWidget {
  final NewsletterFilterViewModel controller;

  const FilterSection({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SearchTextField(controller: controller),
        Row(
          children: [
            _OrderByDropdown(controller: controller),
            _SortOrderDropdown(controller: controller),
            _CategoryDropdown(controller: controller),
          ],
        ),
      ],
    );
  }
}

class _SearchTextField extends StatelessWidget {
  final NewsletterFilterViewModel controller;

  const _SearchTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: controller.setFilterText,
        decoration: InputDecoration(
          labelText: 'Search newsletters',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class _OrderByDropdown extends StatelessWidget {
  final NewsletterFilterViewModel controller;

  const _OrderByDropdown({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => DropdownButton<OrderBy>(
          value: controller.orderBy.value,
          onChanged: (value) => controller.setOrderBy(value ?? OrderBy.title),
          items: OrderBy.values.map((orderBy) {
            String label = orderBy == OrderBy.title ? 'Title' : 'Date';
            return DropdownMenuItem(
              value: orderBy,
              child: Text(label),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _SortOrderDropdown extends StatelessWidget {
  final NewsletterFilterViewModel controller;

  const _SortOrderDropdown({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => DropdownButton<SortOrder>(
          value: controller.sortOrder.value,
          onChanged: (value) =>
              controller.setSortOrder(value ?? SortOrder.ascending),
          items: SortOrder.values.map((sortOrder) {
            String label =
                sortOrder == SortOrder.ascending ? 'Asc ↑' : 'Desc ↓';
            return DropdownMenuItem(
              value: sortOrder,
              child: Text(label),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _CategoryDropdown extends StatelessWidget {
  final NewsletterFilterViewModel controller;

  const _CategoryDropdown({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => DropdownButton<String>(
            isExpanded: true,
            value: controller.selectedCategory.value.isEmpty
                ? null
                : controller.selectedCategory.value,
            onChanged: (value) => controller.setSelectedCategory(value ?? ''),
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text(
                  "All Categories",
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                ),
              ),
              ...controller.availableCategories.map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsletterContent extends StatelessWidget {
  final NewsletterFilterViewModel controller;

  const NewsletterContent({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.filteredNewsletters.isEmpty
          ? const Center(
              child: Text('There are no registered newsletters yet'),
            )
          : NewsletterListWidget(
              newsletterList: controller.filteredNewsletters,
            ),
    );
  }
}
