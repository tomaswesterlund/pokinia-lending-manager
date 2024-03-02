enum LoanTypes {
  openEndedLoan,
  termLoan,
  ballonLoan,
  zeroInterestLoan;

  static LoanTypes fromName(String? name) {
    if (name == null || name.isEmpty) {
      throw Exception("Loan type name can't be null or empty");
    }

    if (name == 'zero_interest_loan') {
      return LoanTypes.zeroInterestLoan;
    } else if (name == 'open_ended_loan') {
      return LoanTypes.openEndedLoan;
    } else if (name == 'term_loan') {
      return LoanTypes.termLoan;
    } else if (name == 'ballon_loan') {
      return LoanTypes.ballonLoan;
    }

    throw Exception("Loan type name not found");
  }
}
