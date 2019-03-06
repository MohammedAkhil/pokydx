class StringUtils {
  static String removeNewLine(String text) {
    return text.replaceAll('\n', ' ');
  }

  static String capitalizeString(String text) {
    return '${text[0].toUpperCase()}${text.substring(1)}';
  }
}
