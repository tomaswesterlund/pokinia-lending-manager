enum PaymentStatus {
  unknown,
  empty,
  deleted,
  paid,
  pending,
  scheduled,
  overdue,
  prompt;

  static PaymentStatus fromName(String? name) {
    if (name == null || name.isEmpty) {
      return PaymentStatus.unknown;
    }
    
    for (PaymentStatus enumVariant in PaymentStatus.values) {
      if (enumVariant.name == name) {
        return enumVariant;
      }
    }
    return PaymentStatus.unknown;
  }
}