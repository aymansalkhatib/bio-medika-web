import 'package:flutter/services.dart';

class MaxValueInputFormatter extends TextInputFormatter {
  final double maxValue;

  MaxValueInputFormatter({required this.maxValue});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final double? value = double.tryParse(newValue.text);
    if (value == null || value > maxValue) {
      return oldValue;
    }
    return newValue;
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (text.length > 10) {
      return oldValue;
    }
    if (newValue.text.length > oldValue.text.length && (text.isNotEmpty && text[text.length - 1] == '-')) {
      return oldValue;
    }

    if (newValue.text.length < oldValue.text.length && (text.isNotEmpty && text[text.length - 1] == '-')) {
      text = text.substring(0, text.length - 1);
      return newValue.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }

    if ((text.length == 4 || text.length == 7) && oldValue.text.length < newValue.text.length) {
      text += '-';
    }
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
