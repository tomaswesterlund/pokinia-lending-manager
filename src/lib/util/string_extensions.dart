extension StringExtensions on String {
  bool isNumeric() {
    RegExp numeric = RegExp(r'^-?[0-9]+$');
    return numeric.hasMatch(this);
  }
}

extension NullableStringExtensions on String? {
  bool isNullOrEmpty() {
    if(this == null) {
      return true;
    } else if (this!.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isANumber() {
    if(this == null) {
      return false;
    } else {
      return this!.isNumeric();
    }
  }

  bool isNotANumber() {
    if(this == null) {
      return false;
    } else {
      return !isANumber();
    }
  }
}