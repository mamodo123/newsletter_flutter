import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../domain/entities/newsletter.dart';

enum OrderBy { title, createdAt }

enum SortOrder { ascending, descending }

class NewsletterFilterViewModel extends GetxController {
  final RxList<Newsletter> newsletters;
  final RxString filterText = ''.obs;
  final RxString selectedCategory = ''.obs;
  final RxList<String> availableCategories = <String>[].obs;
  final Rx<OrderBy> orderBy = OrderBy.createdAt.obs;
  final Rx<SortOrder> sortOrder = SortOrder.ascending.obs;

  final RxList<Newsletter> filteredNewsletters = <Newsletter>[].obs;

  NewsletterFilterViewModel(this.newsletters) {
    newsletters.listen((_) {
      _updateAvailableCategories();
      _updateFilteredNewsletters();
    });

    _updateAvailableCategories();
    _updateFilteredNewsletters();
  }

  void setFilterText(String text) {
    filterText.value = text;
    _updateFilteredNewsletters();
  }

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
    _updateFilteredNewsletters();
  }

  void setOrderBy(OrderBy newOrderBy) {
    orderBy.value = newOrderBy;
    _updateFilteredNewsletters();
  }

  void setSortOrder(SortOrder newSortOrder) {
    sortOrder.value = newSortOrder;
    _updateFilteredNewsletters();
  }

  void _updateAvailableCategories() {
    availableCategories.value = newsletters
        .map((newsletter) => newsletter.category)
        .toSet()
        .toList()
      ..sort();

    if (!availableCategories.contains(selectedCategory.value)) {
      selectedCategory.value = '';
    }
  }

  void _updateFilteredNewsletters() {
    var filtered = newsletters.where((newsletter) {
      final matchesText = newsletter.title
          .toLowerCase()
          .contains(filterText.value.toLowerCase());
      final matchesCategory = selectedCategory.value.isEmpty ||
          newsletter.category == selectedCategory.value;
      return matchesText && matchesCategory;
    }).toList();

    filtered.sort((a, b) {
      int comparison;
      if (orderBy.value == OrderBy.title) {
        comparison = a.title.compareTo(b.title);
      } else if (orderBy.value == OrderBy.createdAt) {
        comparison = a.createdAt.compareTo(b.createdAt);
      } else {
        comparison = 0;
      }

      return sortOrder.value == SortOrder.ascending ? comparison : -comparison;
    });

    filteredNewsletters.value = filtered;
  }
}
