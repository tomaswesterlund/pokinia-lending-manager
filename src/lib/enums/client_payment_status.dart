enum ClientPaymentStatus {
  unknown,
  empty,
  prompt,
  overdue;

  static ClientPaymentStatus fromName(String name) {
    for (ClientPaymentStatus enumVariant in ClientPaymentStatus.values) {
      if (enumVariant.name == name) {
        return enumVariant;
      }
    }
    return ClientPaymentStatus.unknown;
  }
}
