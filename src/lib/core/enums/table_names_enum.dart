enum TableNames {
  clients('clients'),
  currencies('currencies'),
  currencyOrganization('currency_organization'),
  customers('customers'),
  loans('loans'),
  loanStatements('loan_statements'),
  payments('payments'),
  openEndedLoans('open_ended_loans'),
  organizations('organizations'),
  organizationSettings('organizations_settings'),
  userSettings('user_settings'),
  zeroInterestLoans('zero_interest_loans');

  final String value;
  const TableNames(this.value);
}
