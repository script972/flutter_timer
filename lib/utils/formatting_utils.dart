class FormattingUtils {
  static String dateFormatting(int seconds) {
    final now = Duration(seconds: seconds);
    return "${now.inMinutes} : ${now.inSeconds}";
  }

  static String printDuration(int seconds) {
    final now = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(now.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(now.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
