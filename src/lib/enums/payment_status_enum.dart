enum PaymentStatus {
  unknown,
  empty,
  deleted,
  paid,
  scheduled,
  overdue;

  static PaymentStatus fromName(String name) {
    for (PaymentStatus enumVariant in PaymentStatus.values) {
      if (enumVariant.name == name) {
        return enumVariant;
      }
    }
    return PaymentStatus.unknown;
  }
}