import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsletter/src/presentation/newsletter/view_models/newsletter_filter_view_model.dart';

import 'newsletter_list_widget.dart';

class NewsletterFilterList extends StatefulWidget {
  const NewsletterFilterList({super.key});

  @override
  State<NewsletterFilterList> createState() => _NewsletterFilterListState();
}

class _NewsletterFilterListState extends State<NewsletterFilterList> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsletterFilterViewModel>(
      builder: (controller) {
        return Column(
          children: [
            Column(
              children: [
                TextField(
                  onChanged: (text) => controller.setFilterText(text),
                  decoration: InputDecoration(
                    labelText: 'Search newsletters',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() => DropdownButton<OrderBy>(
                            value: controller.orderBy.value,
                            onChanged: (value) =>
                                controller.setOrderBy(value ?? OrderBy.title),
                            items: OrderBy.values.map((orderBy) {
                              String label =
                                  orderBy == OrderBy.title ? 'Title' : 'Date';
                              return DropdownMenuItem(
                                value: orderBy,
                                child: Text(label),
                              );
                            }).toList(),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() => DropdownButton<SortOrder>(
                            value: controller.sortOrder.value,
                            onChanged: (value) => controller
                                .setSortOrder(value ?? SortOrder.ascending),
                            items: SortOrder.values.map((sortOrder) {
                              String label = sortOrder == SortOrder.ascending
                                  ? 'Asc ↑'
                                  : 'Desc ↓';
                              return DropdownMenuItem(
                                value: sortOrder,
                                child: Text(label),
                              );
                            }).toList(),
                          )),
                    ),
                    Expanded(
                      child: Obx(() => DropdownButton<String>(
                            isExpanded: true,
                            value: controller.selectedCategory.value.isEmpty
                                ? null
                                : controller.selectedCategory.value,
                            onChanged: (value) {
                              if (value == null) {
                                controller.setSelectedCategory('');
                              } else {
                                controller.setSelectedCategory(value);
                              }
                            },
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text(
                                  "All Categories",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              ...controller.availableCategories.map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Obx(() => controller.filteredNewsletters.isEmpty
                  ? const Center(
                      child: Text('There are no registered newsletters yet'),
                    )
                  : NewsletterListWidget(
                      newsletterList: controller.filteredNewsletters,
                    )),
            ),
          ],
        );
      },
    );
  }
}
