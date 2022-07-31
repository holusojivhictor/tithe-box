extension DoubleExtensions on double {
  String parseToString() {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String mathFunc(Match match) => '${match[1]},';
    final parsed = toStringAsFixed(1).replaceAllMapped(reg, mathFunc);
    return parsed;
  }
}