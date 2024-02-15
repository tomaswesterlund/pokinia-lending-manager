extension StringExtensions on String {
  bool isNumeric() {
    RegExp numeric = RegExp(r'^-?[0-9]+$');
    return numeric.hasMatch(this);
  }

  String getInitials() {
    if (isEmpty) {
      return '';
    } else {
      return trim().split(RegExp(' +')).map((s) => s[0]).take(2).join();
    }
  }
}

extension NullableStringExtensions on String? {
  bool isNullOrEmpty() {
    if (null == this || this!.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isNotNullOrEmpty() {
    return !isNullOrEmpty();
  }

  bool isNumeric() {
    try {
      if (this == null) return false;

      var res = int.tryParse(this!);

      if (res == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  bool isNotNumeric() {
    return !isNumeric();
  }

  bool isNumericOrFloating() {
    try {
      if (this == null) return false;

      var res = double.tryParse(this!);

      if (res == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  bool isNotNumericOrFloating() {
    return !isNumericOrFloating();
  }
}
