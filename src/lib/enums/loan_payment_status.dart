enum LoanPaymentStatus {
  unknown,
  empty,
  prompt,
  pending,
  overdue;

  static LoanPaymentStatus fromName(String name) {
    for (LoanPaymentStatus enumVariant in LoanPaymentStatus.values) {
      if (enumVariant.name == name) {
        return enumVariant;
      }
    }
    return LoanPaymentStatus.unknown;
  }
}