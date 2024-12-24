class ValidationError implements Exception {
  final Map<String, String> errors;

  const ValidationError({required this.errors});

  @override
  String toString() {
    final errorList =
        errors.entries.map((entry) => '${entry.key}: ${entry.value}').toList();
    return 'ValidationError: ${errorList.join(', ')}';
  }
}
