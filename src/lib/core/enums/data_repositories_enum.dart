enum DataRepositories {
  clientRepository('clientRepository'),
  currencyOrganizationRepository('currencyOrganizationRepository'),
  currencyRepository('currencyRepository'),
  customerRepository('customerRepository'),
  loanRepository('loanRepository'),
  loanStatementRepository('loanStatementRepository'),
  paymentRepository('paymentsRepository'),
  openEndedLoanRepository('openEndedLoanRepository'),
  organizationRepository('organizationRepository'),
  organizationSettingsRepository('organizationSettingsRepository'),
  userSettingsRepository('userSettingsRepository'),
  zeroInterestLoansRepository('zeroInterestLoansRepository');

  final String value;
  const DataRepositories(this.value);
}
