class Validators {
  static String? validateTitle(String? value) {
    if (value == null || value.trim().length < 3) {
      return 'Title must be at least 3 characters long.';
    }
    return null;
  }

  static String? validateCategory(String? value) {
    if (value == null || value.trim().length < 3) {
      return 'Category must be at least 3 characters long.';
    }
    return null;
  }

  static String? validateSummary(String? value) {
    if (value == null || value.trim().length < 3) {
      return 'Summary must be at least 3 characters long.';
    }
    return null;
  }

  static String? validateLink(String? value) {
    const urlPattern =
        r"^(https?:\/\/)?([\w\-])+(\.[\w\-]+)+[\w\-\._~:/?#[\]@!\$&\'()*\+,;=.]+$";
    final urlRegExp = RegExp(urlPattern);
    if (value == null || value.isEmpty) {
      return 'Link is required.';
    } else if (!urlRegExp.hasMatch(value)) {
      return 'Please enter a valid URL.';
    }
    return null;
  }
}
