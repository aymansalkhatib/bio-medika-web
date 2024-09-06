bool isDateRangeFormatCorrect(String dateRange) {
  try {
    List<String> dates = dateRange.split('><');
    if (dates.length != 2) {
      return false;
    }

    if (DateTime.parse(dates[0]).toString().substring(0, 10) == dateRange.substring(0, 10) &&
        DateTime.parse(dates[1]).toString().substring(0, 10) == dateRange.substring(12, 22)) {
      return true;
    }

    return false;
  } on FormatException {
    return false;
  }
}

bool isDateInRange(String firstDate, String dateRange) {
  try {
    DateTime firstDateTime = DateTime.parse(firstDate);

    List<String> dates = dateRange.split('><');
    if (dates.length != 2) {
      return false;
    }

    DateTime startDateTime = DateTime.parse(dates[0]);
    DateTime endDateTime = DateTime.parse(dates[1]);

    return firstDateTime.isAfter(startDateTime) && firstDateTime.isBefore(endDateTime);
  } on FormatException {
    return false;
  }
}

bool areFormatsCorrectForBeforeAfterCheck(String comparison) {
  try {
    String compDate = comparison.substring(0, comparison.length - 1);
    String tag = comparison.substring(comparison.length - 1);

    DateTime.parse(compDate);

    if (tag != '>' && tag != '<') {
      return false;
    }

    return true;
  } on FormatException {
    return false;
  }
}

bool isDateBeforeOrAfter(String myDate, String comparison) {
  try {
    DateTime myDateTime = DateTime.parse(myDate);

    String compDate = comparison.substring(0, comparison.length - 1);
    String tag = comparison.substring(comparison.length - 1);

    DateTime comparisonDateTime = DateTime.parse(compDate);

    if (tag == '>') {
      return myDateTime.isAfter(comparisonDateTime);
    } else if (tag == '<') {
      return myDateTime.isBefore(comparisonDateTime);
    } else {
      return false;
    }
  } on FormatException {
    return false;
  }
}
